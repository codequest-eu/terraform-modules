package main

import (
	"encoding/json"
	"fmt"
	"os"
	"strings"
	"text/template"

	"github.com/hashicorp/hcl/v2"
	"github.com/hashicorp/hcl/v2/hclparse"
	"github.com/hashicorp/terraform-config-inspect/tfconfig"
	flag "github.com/spf13/pflag"
)

func main() {
	flag.Parse()

	var dir string
	if flag.NArg() > 0 {
		dir = flag.Arg(0)
	} else {
		dir = "."
	}

	module, _ := tfconfig.LoadModule(dir)

	showModuleMarkdown(module)

	if module.Diagnostics.HasErrors() {
		os.Exit(1)
	}
}

func showModuleMarkdown(module *tfconfig.Module) {
	tmpl := template.New("md")
	tmpl.Funcs(template.FuncMap{
		"isVariableOptional": func(variable *tfconfig.Variable) bool {
			if variable.Default != nil {
				return true
			}

			// HACK:
			// workaround for default = null, which make a variable optional, but
			// there's no difference in tfconfig.Variable between default = null
			// and no default at all
			block := parseVariable(variable.Pos.Filename, variable.Name)
			_, hasDefault := block.Attributes["default"]
			return hasDefault
		},
		"tt": func(s string) string {
			return "`" + s + "`"
		},
		"commas": func(s []string) string {
			return strings.Join(s, ", ")
		},
		"json": func(v interface{}) (string, error) {
			j, err := json.Marshal(v)
			return string(j), err
		},
		"severity": func(s tfconfig.DiagSeverity) string {
			switch s {
			case tfconfig.DiagError:
				return "Error: "
			case tfconfig.DiagWarning:
				return "Warning: "
			default:
				return ""
			}
		},
	})

	template.Must(tmpl.Parse(markdownTemplate))

	err := tmpl.Execute(os.Stdout, module)
	if err != nil {
		fmt.Fprintf(os.Stderr, "error rendering template: %s\n", err)
		os.Exit(2)
	}
}

const markdownTemplate = `
## Versions

| Provider | Requirements |
|-|-|
| terraform | {{ if .RequiredCore }}{{ commas .RequiredCore | tt }}{{ else }}(any version){{ end }} |
{{- range $name, $req := .RequiredProviders }}
| {{ tt $name }}{{ if $req.Source }} ({{ $req.Source | tt }}){{ end }} | {{ if $req.VersionConstraints }}{{ commas $req.VersionConstraints | tt }}{{ else }}(any version){{ end }} |
{{- end}}

{{- if .Variables}}

## Inputs

{{ range $i, $var := .Variables -}}
* {{ tt .Name }} ({{ tt .Type }}, {{ if $var | isVariableOptional }}default: {{ json .Default | tt }}{{else}}required{{end}})

    {{ .Description }}

{{end}}
{{- end}}

{{- if .Outputs}}

## Outputs

{{ range .Outputs -}}
* {{ tt .Name }}

    {{ .Description }}

{{end}}
{{- end}}

{{- if .Diagnostics}}

## Problems
{{- range .Diagnostics }}

## {{ severity .Severity }}{{ .Summary }}{{ if .Pos }}

(at {{ tt .Pos.Filename }} line {{ .Pos.Line }}{{ end }})
{{ if .Detail }}
{{ .Detail }}
{{- end }}

{{- end}}{{end}}

`

var parseCache = make(map[string]*hcl.File)

func parse(filename string) *hcl.File {
	file, fileCached := parseCache[filename]

	if !fileCached {
		parser := hclparse.NewParser()
		file, _ = parser.ParseHCLFile(filename)
		parseCache[filename] = file
	}

	return file
}

var variableCache = make(map[string]*hcl.BodyContent)

func parseVariable(filename string, name string) *hcl.BodyContent {
	_, cached := variableCache[name]

	if !cached {
		file := parse(filename)
		fileContent, _, _ := file.Body.PartialContent(rootSchema)

		for _, block := range fileContent.Blocks.OfType("variable") {
			blockName := block.Labels[0]
			blockContent, _, _ := block.Body.PartialContent(variableSchema)
			variableCache[blockName] = blockContent
		}
	}

	return variableCache[name]
}

# You can pass the contents of the archive inline
module "zip_inline" {
  source = "./.."

  files = {
    "index.html" = file("${path.module}/index.html")
    "index.js"   = file("${path.module}/index.js")
  }
}

output "zip_inline" {
  value = module.zip_inline
}

# You can also zip a directory and pass include and exclude patterns to narrow what's included in the zip
module "zip_dir" {
  source = "./.."

  directory                  = path.module
  directory_include_patterns = ["**/*.html", "**/*.js"]
  directory_exclude_patterns = [".terraform/**", "**/*.tf"]
}

output "zip_dir" {
  value = module.zip_dir
}

# You can specify a custom output path, {hash} will be replaced with a hash of the zip's content
module "zip_custom_output_path" {
  source = "./.."

  files = {
    "index.html" = file("${path.module}/index.html")
    "index.js"   = file("${path.module}/index.js")
  }

  output_path = "${path.module}/tmp/{hash}.zip"
}

output "zip_custom_output_path" {
  value = module.zip_custom_output_path
}


# Since you can't read binary files with `file()`, they need to be ziped using the `directory` input
module "zip_binary_content" {
  source = "./.."

  directory                  = path.module
  directory_include_patterns = ["index.zip"]
}

output "zip_binary_content" {
  value = module.zip_binary_content
}

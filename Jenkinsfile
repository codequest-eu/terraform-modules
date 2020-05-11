
node {
  def git = checkout scm
  def commit = git.GIT_COMMIT
  def branch = env.BRANCH_NAME
  def targetBranch = env.CHANGE_TARGET ?: env.BRANCH_NAME

  echo "commit: ${commit}"
  echo "branch: ${branch}"
  echo "targetBranch: ${targetBranch}"

  def image = docker.build(
    "terraform-modules-jenkins:${git.GIT_COMMIT}",
    "-f Jenkins.Dockerfile ."
  )

  image.inside {
    def moduleDirs = sh(
      script: "find . -name variables.tf -o -name outputs.tf -exec dirname '{}' \\; | sort -u",
      returnStdout: true
    ).split("\n")

    def exampleDirs = sh(
      script: "find . -name '*.tf' -exec dirname '{}' \\; | sort -u | egrep '/examples?(\$|/)'",
      returnStdout: true
    ).split("\n")

    def pluginsDir = "${pwd()}/.terraform/plugins/linux_amd64"

    def runEachDir = { dirs, errorMessage, script ->
      def dirStatuses = dirs.collectEntries { dir ->
        try {
          script(dir)
          return [(dir): true]
        } catch (err) {
          return [(dir): false]
        }
      }

      def failedDirs = dirStatuses.findAll({ !it.value }).collect({ it.key })
      if (failedDirs.size() > 0) {
        error("${errorMessage}:\n${failedModules.join('\n')}")
      }
    }

    def shEachDir = { dirs, errorMessage, scriptFactory ->
      runEachDir dirs, errorMessage, { dir -> sh(scriptFactory(dir)) }
    }

    try {
      stage("download providers") {
        sh 'terraform init -backend=false -upgrade=true'
      }

      stage("terraform init modules") {
        runEachDir(moduleDirs, "Failed to init", { moduleDir ->
          sh "cd ${moduleDir} && terraform init -backend=false -plugin-dir='${pluginsDir}'"
        })
      }

      stage("terraform fmt") {
        runEachDir(moduleDirs, "Formatting error", { moduleDir ->
          sh "cd ${moduleDir} && terraform fmt -check -diff"
        })
      }

      stage("terraform validate modules") {
        withEnv([
          // required to validate modules which use the aws provider
          "AWS_REGION=eu-west-1"
        ]) {
          runEachDir(moduleDirs, "Failed to validate", { moduleDir ->
            sh "cd ${moduleDir} && terraform validate"
          })
        }
      }

      stage("tflint modules") {
        runEachDir(moduleDir, "Failed to tflint", { moduleDir ->
          sh "cd ${moduleDir} && tflint --config \$TFLINT_CONFIG"
        })
      }

      stage("check module docs") {
        runEachDir(moduleDirs, "Outdated docs", { moduleDir ->
          def moduleReadme = "${moduleDir}/README.md"

          if (!fileExists(moduleReadme)) {
            error("Missing ${moduleReadme}")
          }

          try {
            sh "cat '${moduleReadme}' | grep -qF '<!-- bin/docs -->'"
          } catch (err) {
            error("Missing bin/docs marker in ${moduleReadme}")
          }

          try {
            sh "\$TOOLS_BIN/update-docs '${moduleReadme}' && git diff --quiet '${moduleReadme}'"
          } catch (err) {
            error("${moduleReadme} is out of date")
          } finally {
            sh "git checkout '${moduleReadme}'"
          }
        })
      }

      stage("terraform init examples") {
        runEachDir exampleDirs, "Failed to init", { exampleDir ->
          sh "cd ${exampleDir} && terraform init -backend=false -plugin-dir='${pluginsDir}'"
        }
      }

      stage("terraform validate examples") {
        runEachDir exampleDirs, "Failed to validate", { exampleDir ->
          sh "cd ${exampleDir} && terraform validate"
        }
      }
    } finally {
      stage("remove providers") {
        sh "rm -rf '${pluginsDir}'"
      }
    }
  }
}

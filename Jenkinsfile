
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


    stage("terraform fmt") {
      sh 'terraform fmt -check -recursive -diff'
    }

    stage("docs") {
      parallel moduleDirs.collectEntries { moduleDir ->
        def moduleReadme = "${moduleDir}/README.md"

        [(moduleDir): {
          stage(moduleDir) {
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
          }
        }]
      }
    }

    stage("terraform init") {
      parallel exampleDirs.collectEntries { exampleDir ->
        [(exampleDir): {
          stage(exampleDir) {
            sh "cd ${exampleDir} && terraform init -backend=false"
          }
        }]
      }
    }

    stage("terraform validate") {
      parallel exampleDirs.collectEntries { exampleDir ->
        [(exampleDir): {
          stage(exampleDir) {
            sh "cd ${exampleDir} && terraform validate"
          }
        }]
      }
    }

    stage("tflint") {
      parallel exampleDirs.collectEntries { exampleDir ->
        [(exampleDir): {
          stage(exampleDir) {
            sh "cd ${exampleDir} && tflint --module"
          }
        }]
      }
    }
  }
}

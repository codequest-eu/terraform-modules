
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
    stage("terraform fmt") {
      sh 'terraform fmt -check -recursive -diff'
    }

    def exampleDirectories = sh(
      script: "find . -name '*.tf' -exec dirname '{}' \\; | sort -u | egrep '/examples?(\$|/)'",
      returnStdout: true
    ).split("\n")

    stage("terraform init") {
      parallel exampleDirectories.collectEntries { exampleDir ->
        [(exampleDir): {
          stage(exampleDir) {
            sh "cd ${exampleDir} && terraform init"
          }
        }]
      }
    }

    stage("terraform validate") {
      parallel exampleDirectories.collectEntries { exampleDir ->
        [(exampleDir): {
          stage(exampleDir) {
            sh "cd ${exampleDir} && terraform validate"
          }
        }]
      }
    }
  }
}

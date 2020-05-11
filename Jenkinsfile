
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

    def moduleStage = { name, script ->
      stage("modules: ${name}") {
        runEachDir(moduleDirs, "${name} failed", script)
      }
    }

    def exampleStage = { name, script ->
      stage("examples: ${name}") {
        runEachDir(exampleDirs, "${name} failed", script)
      }
    }

    try {
      stage("download providers") {
        sh 'terraform init -backend=false -upgrade=true'
      }

      moduleStage("terraform init") { dir ->
        sh "cd ${dir} && terraform init -backend=false -plugin-dir='${pluginsDir}'"
      }

      moduleStage("terraform fmt") { dir ->
        sh "cd ${dir} && terraform fmt -check -diff"
      }

      moduleStage("terraform validate") { dir ->
        withEnv([
          // required to validate modules which use the aws provider
          "AWS_REGION=eu-west-1"
        ]) {
          sh "cd ${dir} && terraform validate"
        }
      }

      moduleStage("tflint") { dir ->
        sh "cd ${dir} && tflint --config \$TFLINT_CONFIG"
      }

      moduleStage("docs updated") { dir ->
        def moduleReadme = "${dir}/README.md"

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

      exampleStage("terraform init") { dir ->
        sh "cd ${dir} && terraform init -backend=false -plugin-dir='${pluginsDir}'"
      }

      exampleStage("terraform fmt") { dir ->
        sh "cd ${dir} && terraform fmt -check -diff"
      }

      exampleStage("terraform validate") { dir ->
        sh "cd ${dir} && terraform validate"
      }
    } finally {
      stage("remove providers") {
        sh "rm -rf '${pluginsDir}'"
      }
    }
  }
}

const core = require("@actions/core")
const cache = require("@actions/cache")

async function run() {
  try {
    const key = core.getInput("key", { required: true })
    const paths = core
      .getInput("path", { required: true })
      .split("\n")
      .map(path => path.trim())
      .filter(path => path !== "")

    const hitKey = await cache.restoreCache(paths, key)

    if (!hitKey) {
      core.setFailed(`Cache not found for key: ${key}`)
    }
  } catch (error) {
    core.setFailed(error.message)
  }
}

run()

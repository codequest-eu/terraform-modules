const fs = require("fs")
const path = require("path")
const crypto = require("crypto")

const dataPath = path.join(__dirname, "index.zip")

async function handler() {
  const dataHash = crypto.createHash("md5")
  dataHash.update(fs.readFileSync(dataPath))

  console.log(`${dataPath} MD5: ${dataHash.digest("hex")}`)
}

module.exports = { handler }

// allow running the handler with `node index.js` for testing locally
if (require.main === module) {
  handler()
}

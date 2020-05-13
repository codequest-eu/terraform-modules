const https = require("https")

async function getPublicIp() {
  return new Promise((resolve, reject) => {
    https.get("https://checkip.amazonaws.com/", res => {
      const { statusCode, statusMessage } = res

      if (statusCode !== 200) {
        res.resume()
        return reject(new Error(`${statusCode} ${statusMessage}`))
      }

      res.setEncoding("utf8")
      let data = ""
      res.on("data", chunk => (data += chunk))
      res.on("end", () => resolve(data))
    })
  })
}

async function handler() {
  console.log("public ip", await getPublicIp())
}

module.exports = { handler }

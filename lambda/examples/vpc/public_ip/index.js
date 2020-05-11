const https = require("https")

async function getPublicIp() {
  return new Promise((resolve, reject) => {
    https.get("https://api.ipify.org?format=json", res => {
      const { statusCode, statusMessage } = res

      if (statusCode !== 200) {
        res.resume()
        return reject(new Error(`${statusCode} ${statusMessage}`))
      }

      res.setEncoding("utf8")
      let data = ""
      res.on("data", chunk => (data += chunk))
      res.on("end", () => {
        try {
          resolve(JSON.parse(data).ip)
        } catch (err) {
          reject(err)
        }
      })
    })
  })
}

async function handler() {
  console.log("public ip", await getPublicIp())
}

module.exports = { handler }

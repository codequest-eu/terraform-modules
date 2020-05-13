const { greet } = require("./greeter")

async function handler() {
  greet("Lambda")
}

module.exports = { handler }

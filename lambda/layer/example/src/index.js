const Ajv = require("ajv").default
const addFormats = require("ajv-formats")

const ajv = new Ajv({
  allErrors: true,
})
addFormats(ajv)

async function handler(event) {
  const validate = ajv.compile({
    type: "object",
    required: ["name", "email"],
    properties: {
      name: { type: "string", minLength: 3 },
      email: { type: "string", format: "email" },
    },
  })

  if (validate(event)) {
    console.log("valid")
  } else {
    console.log("invalid", validate.errors)
  }
}

module.exports = { handler }

// allow running index.js from command line for testing
// NODE_PATH=./nodejs/node_modules node index.js EVENT
if (require.main === module) {
  const event =
    typeof process.argv[2] === "string"
      ? JSON.parse(process.argv[2])
      : undefined
  handler(event)
}

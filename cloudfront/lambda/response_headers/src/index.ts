import {
  CloudFrontHeaders,
  CloudFrontResponseEvent,
  CloudFrontResponseHandler,
} from "aws-lambda"
import micromatch from "micromatch"

interface Rule {
  path: string
  contentType: string
  headers: Record<string, string>
}

const rules = require("./rules.json") as Rule[]

export const handler: CloudFrontResponseHandler = async event => {
  const { request, response } = event.Records[0].cf

  console.log({ request, response })

  const contentType = getHeaderValue(response.headers, "content-type")

  rules.forEach(rule => {
    if (micromatch.isMatch(contentType, rule.contentType)) {
      setHeaderValues(response.headers, rule.headers)
    }
  })

  return response
}

function getHeaderValue(headers: CloudFrontHeaders, name: string) {
  return headers[name.toLowerCase()]?.[0]?.value || ""
}

function setHeaderValue(
  headers: CloudFrontHeaders,
  name: string,
  value: string,
) {
  headers[name.toLowerCase()] = [{ key: name, value }]
}

function setHeaderValues(
  headers: CloudFrontHeaders,
  values: Record<string, string>,
) {
  Object.entries(values).forEach(([name, value]) => {
    setHeaderValue(headers, name, value)
  })
}

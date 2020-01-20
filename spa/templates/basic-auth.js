// Workaround for https://github.com/terraform-providers/terraform-provider-aws/issues/11592
// Runtime: nodejs 10.x

// Expected Authorization header value
const authorization = "Basic ${credentials}"

exports.handler = (event, context, callback) => {
  // Get request and request headers
  const request = event.Records[0].cf.request
  const headers = request.headers

  // Require Basic authentication
  if (
    !headers.authorization ||
    headers.authorization[0].value !== authorization
  ) {
    return callback(null, {
      status: "401",
      statusDescription: "Unauthorized",
      body: "Unauthorized",
      headers: {
        "www-authenticate": [{ key: "WWW-Authenticate", value: "Basic" }],
      },
    })
  }

  // Continue request processing if authentication passed
  callback(null, request)
}

// Expected Authorization header value
const authorization = "Basic ${credentials}"

// List of regular expressions describing paths excluded from the basic auth
const exclusions = ${exclusion_patterns}.map(pattern => new RegExp(pattern))

exports.handler = (event, context, callback) => {
  // Get request and request headers
  const request = event.Records[0].cf.request
  const headers = request.headers

  // Require Basic authentication unless the exclusions include the request path
  if (
    exclusions.some(re => re.test(request.uri)) ||
    (headers.authorization && headers.authorization[0].value === authorization)
  ) {
    // Continue request processing if authentication passed
    return callback(null, request)
  }

  callback(null, {
    status: "401",
    statusDescription: "Unauthorized",
    body: "Unauthorized",
    headers: {
      "www-authenticate": [{ key: "WWW-Authenticate", value: "Basic" }],
    },
  })
}

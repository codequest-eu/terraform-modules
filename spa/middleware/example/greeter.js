exports.handler = (event, context, callback) => {
  const response = event.Records[0].cf.response
  response.headers["${greeting}"] = "${subject}"
  callback(null, response)
}

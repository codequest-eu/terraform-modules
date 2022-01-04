function requireBasicAuth(event) {
  var expectedAuthorization = "Basic ${credentials}";
  var headers = event.request.headers;

  if (
    !headers.authorization ||
    headers.authorization.value !== expectedAuthorization
  ) {
    return {
      statusCode: 401,
      statusDescription: "Unauthorized",
      headers: {
        "www-authenticate": { value: "Basic" },
      },
    };
  }
}

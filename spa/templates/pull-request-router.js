// Workaround for https://github.com/terraform-providers/terraform-provider-aws/issues/11592
// Runtime: nodejs 10.x

const path = require("path")

const r = String.raw
const pathRe = new RegExp(r`${path_re}`)

exports.handler = (evt, ctx, cb) => {
  const { request } = evt.Records[0].cf
  console.log("<-", request.uri)

  const match = pathRe.exec(request.uri)
  const extension = path.extname(request.uri)

  if (match && !extension) {
    request.uri = `/$${match[1]}/index.html`
  }

  console.log("->", request.uri)
  cb(null, request)
}

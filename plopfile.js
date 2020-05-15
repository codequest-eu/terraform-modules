module.exports = function (plop) {
  plop.setGenerator("module", {
    description: "creates a standard module structure",
    prompts: [{ name: "path" }],
    actions: [
      {
        type: "addMany",
        destination: "{{ path }}",
        base: ".plop/module",
        templateFiles: ".plop/module/**/*",
      },
    ],
  })
}

import json from "@rollup/plugin-json"
import commonjs from "@rollup/plugin-commonjs"
import resolve from "@rollup/plugin-node-resolve"
import typescript from "@rollup/plugin-typescript"

export default {
  input: "./index.ts",
  output: {
    dir: "../dist",
    format: "cjs",
    chunkFileNames: "[name].js",
  },
  manualChunks(id) {
    if (id.includes("node_modules")) {
      return "node_modules"
    }
  },
  plugins: [typescript(), commonjs(), json(), resolve()],
}

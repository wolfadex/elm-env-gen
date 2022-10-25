#!/usr/bin/env node

const [, , inputFile, outputDir, maybeWatch] = process.argv;

const elmCodegen = require("elm-codegen");

elmCodegen.run(inputFile, {
  output: outputDir,
  watch: maybeWatch === "--watch",
});

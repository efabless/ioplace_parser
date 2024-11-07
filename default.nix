{
  lib,
  black,
  nix-gitignore,
  buildPythonPackage,
  poetry-core,
  setuptools,
  pytest,
  coverage,
  antlr4_9,
  antlr4_9-runtime,
}:
buildPythonPackage {
  name = "ioplace_parser";
  version = (builtins.fromTOML (builtins.readFile ./pyproject.toml)).tool.poetry.version;
  format = "pyproject";

  src = nix-gitignore.gitignoreSourcePure ./.gitignore ./.;

  nativeBuildInputs = [
    poetry-core
    antlr4_9
  ];

  propagatedBuildInputs = [
    antlr4_9-runtime
  ];

  nativeCheckInputs = [
    pytest
    black
    coverage
  ];

  preBuild = "make antlr";
  checkPhase = "pytest";
}

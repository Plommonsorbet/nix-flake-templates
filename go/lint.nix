{
  runCommand,
  go,
  golangci-lint,
}:
runCommand "go-lint" {
  nativeBuildInputs = [go golangci-lint];
  src = ./.;
}
''
  cd $src
  HOME=$TMPDIR golangci-lint run
  touch $out
''

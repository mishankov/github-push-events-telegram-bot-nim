lint:
	nimpretty src/*.nim

run:
	nim c -d:ssl -f:on -o:build/main -r src/main

html: out/index.html

clean:
	rm out/*

out/index.html: src/index.adoc src/bash.adoc src/sleep.adoc
	asciidoctor -D out/ src/index.adoc


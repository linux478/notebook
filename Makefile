html: out/index.html

clean:
	rm out/*

out/index.html:
	asciidoctor -D out/ src/index.adoc


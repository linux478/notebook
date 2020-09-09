html: out/index.html out/sleep.png

clean:
	rm out/*

out/index.html: src/index.adoc src/bash.adoc src/sleep.adoc
	asciidoctor -D out/ src/index.adoc

out/sleep.png:
	gnuplot src/sleep.p

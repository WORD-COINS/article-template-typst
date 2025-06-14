TYPST = typst

.PHONY: compile watch clean

compile:
	$(TYPST) compile --root=../../ --font-path=../../fonts/ main.typ main.pdf

watch:
	$(TYPST) watch --root=../../ --font-path=../../fonts/ main.typ main.pdf

clean:
	rm -rf *.pdf

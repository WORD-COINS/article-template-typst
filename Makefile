TYPST = typst

.PHONY: compile
compile:
	$(TYPST) compile --root=. --font-path=fonts main.typ main.pdf

.PHONY: watch
watch:
	$(TYPST) watch --root=. --font-path=fonts main.typ main.pdf

.PHONY: clean
clean:
	rm -rf *.pdf
	rm -rf fonts

.PHONY: check
check:
	./scripts/list.sh | ./scripts/check.sh

.PHONY: setup
setup:
	./scripts/list.sh | ./scripts/install.sh

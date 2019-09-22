PLANTUML_URL = https://sourceforge.net/projects/plantuml/files/plantuml.jar/download
GRAPHVIZ := $(shell command -v dot 2> /dev/null)
DIAGRAMS_SRC := $(wildcard */docs/diagrams/*.pu */diagrams/*.pu)
DIAGRAMS_PNG := $(addsuffix .png, $(basename $(DIAGRAMS_SRC)))

png: graphviz plantuml.jar $(DIAGRAMS_PNG)

graphviz:
ifndef GRAPHVIZ
	$(error "please install graphviz: brew install graphviz")
endif

plantuml.jar:
	curl -sSfL $(PLANTUML_URL) -o plantuml.jar

# Creates PNG from top-level diagrams (docs/diagrams)
*/diagrams/%.png: */diagrams/%.pu
	java -jar plantuml.jar -config ./plantuml.cfg -tpng $^

# Creates PNG from inner-level diagrams (<dir>/docs/diagrams)
*/docs/diagrams/%.png: */docs/diagrams/%.pu
	java -jar plantuml.jar -config ./plantuml.cfg -tpng $^

clean:
	rm -rf plantuml.jar $(DIAGRAMS_PNG)

.PHONY: clean png graphviz

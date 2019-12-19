PLANTUML_URL = https://sourceforge.net/projects/plantuml/files/plantuml.jar/download
GRAPHVIZ := $(shell command -v dot 2> /dev/null)
DIAGRAMS_SRC := $(shell find . -name '*.pu')
DIAGRAMS_PNG := $(addsuffix .png, $(basename $(DIAGRAMS_SRC)))

png: graphviz plantuml.jar $(DIAGRAMS_PNG)

graphviz:
ifndef GRAPHVIZ
	$(error "please install graphviz: brew install graphviz")
endif

plantuml.jar:
	@curl -sSfL $(PLANTUML_URL) -o plantuml.jar

$(DIAGRAMS_PNG): $(DIAGRAMS_SRC)
	@java -jar plantuml.jar -config ./plantuml.cfg -tpng $^

clean:
	rm -rf plantuml.jar $(PNGS)

.PHONY: clean png graphviz

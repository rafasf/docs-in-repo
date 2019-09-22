PLANTUML_URL = https://sourceforge.net/projects/plantuml/files/plantuml.jar/download
DIAGRAMS_SRC := $(wildcard */docs/diagrams/*.pu */diagrams/*.pu)
DIAGRAMS_PNG := $(addsuffix .png, $(basename $(DIAGRAMS_SRC)))

png: plantuml.jar $(DIAGRAMS_PNG)

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

.PHONY: clean png

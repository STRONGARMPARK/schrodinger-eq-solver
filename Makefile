MODULES=evolution1d
OBJECTS=$(MODULES:=.cmo)
MLS=$(MODULES:=.ml)
#MLIS=$(MODULES:=.mli)
#TEST=test.byte
MAIN=testing-graphs.byte
OCAMLBUILD=ocamlbuild -use-ocamlfind

default: build
	OCAMLRUNPARAM=b utop

build:
	$(OCAMLBUILD) $(OBJECTS)

test:
	$(OCAMLBUILD) -tag 'debug' $(TEST) && ./$(TEST) -runner sequential

graph:
	$(OCAMLBUILD) -tag 'debug' $(MAIN) && OCAMLRUNPARAM=b ./$(MAIN)

zip:
	zip adventure.zip *.ml* *.json *.sh _tags .merlin .ocamlformat .ocamlinit LICENSE Makefile	

clean:
	ocamlbuild -clean
	rm -rf _doc.public _doc.private adventure.zip

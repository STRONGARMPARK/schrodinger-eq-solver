MODULES=evolution graphs graphs2d userint 
OBJECTS=$(MODULES:=.cmo)
MLS=$(MODULES:=.ml)
MLIS=graphs.mli authors.mli graphs2d.mli userint.mli
TEST=test.byte
GRAPH=graphs.byte
MAIN=userint.byte
OCAMLBUILD=ocamlbuild -use-ocamlfind

default: build
	OCAMLRUNPARAM=b utop 

build:
	$(OCAMLBUILD) $(OBJECTS)

test:
	$(OCAMLBUILD) -tag 'debug' $(TEST) && ./$(TEST) -runner sequential

graph:
	$(OCAMLBUILD) -tag 'debug' $(GRAPH) && OCAMLRUNPARAM=b ./$(GRAPH)

go:
	$(OCAMLBUILD) -tag 'debug' $(MAIN) && OCAMLRUNPARAM=b ./$(MAIN)

zip:
	zip schrodinger.zip *.ml* *.txt* _tags .merlin .ocamlformat Makefile	

docs: docs-private docs-public

docs-public: build
	mkdir -p _doc.public
	ocamlfind ocamldoc -I _build -package ANSITerminal \
		-html -stars -d _doc.public $(MLIS)

docs-private: build
	mkdir -p _doc.private
	ocamlfind ocamldoc -I _build -package graphics,ANSITerminal \
		-html -stars -d _doc.private \
		-inv-merge-ml-mli -m A $(MLIS) $(MLS)

clean:
	ocamlbuild -clean
	rm -rf _doc.public _doc.private schrodinger.zip

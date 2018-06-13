# remove any existing owl files in the directory
rm *.owl

# copy dev ontology and imports into directory
cp ../osci-dev.owl .
cp ../imports/*import.owl .

# merge owl files
robot merge \
  --inputs "*.owl"\
  --include-annotations true \
  --output osci-merged.owl
   
# add date to IRI version; e.g.: http://purl.obolibrary.org/obo/2018-06-05/osci.owl
robot annotate \
  --input osci-merged.owl \
  --ontology-iri "http://purl.obolibrary.org/obo/osci.owl" \
  --version-iri "http://purl.obolibrary.org/obo/`date '+%Y-%m-%d'`/osci.owl" \
  --output osci-annotated.owl

# run reasoner on the ontology and add inferred axioms to final output (osci.owl)
robot reason \
	--input osci-annotated.owl \
  --reasoner HermiT \
  --annotate-inferred-axioms true \
  --output osci.owl

# remove imports (clean up)
rm *import.owl
  
# robot \
#   merge --input osci-annotated.owl \
#   reason --reasoner HermiT \
#   --output osci-reasoned.owl

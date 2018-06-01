cp ../osci-dev.owl .
cp ../imports/CLO_import.owl .
cp ../imports/OBI_import.owl .
cp ../imports/OBIB_import.owl .
cp ../imports/OGG_import.owl .
cp ../imports/OMRSE_import.owl .

robot \
  merge robot merge --inputs "*.owl" --output osci-merged.owl
   
robot annotate --input osci-merged.owl \
  --ontology-iri "http://purl.obolibrary.org/obo/osci.owl" \
  --version-iri "http://purl.obolibrary.org/obo/`date '+%Y-%m-%d'`/osci.owl" \
  --output osci-annotated.owl

robot \
  reduce --input osci-annotated.owl --output osci-reduced.owl
  
# robot \
#   merge --input osci-annotated.owl \
#   reason --reasoner ELK \
#   --output osci-reasoned.owl

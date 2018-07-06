# remove any existing owl files in the directory
rm *.owl

# copy dev ontology and imports into directory
cp ../osci-dev.owl .
cp ../imports/*import.owl .

# since the robot.jar file is in the directory, calls to robot are made using the java -jar ./robot.jar command
# alternatively, you can call robot directly if your system is configured properly 
# for example, if the path to robot is in your PATH environment variable 
# you can perform merge by simple executing robot merge

# merge owl files
java -jar ./robot.jar merge \
  --inputs "*.owl"\
  --include-annotations true \
  --output osci-merged.owl
   
# add date to IRI version; e.g.: http://purl.obolibrary.org/obo/2018-06-05/osci.owl
java -jar ./robot.jar annotate \
  --input osci-merged.owl \
  --ontology-iri "http://purl.obolibrary.org/obo/osci.owl" \
  --version-iri "http://purl.obolibrary.org/obo/`date '+%Y-%m-%d'`/osci.owl" \
  --output osci-annotated.owl

# run reasoner on the ontology and add inferred axioms to final output (osci.owl)
java -jar ./robot.jar reason \
	--input osci-annotated.owl \
  --reasoner HermiT \
  --annotate-inferred-axioms true \
  --output osci.owl

# clean up
# remove imports 
rm *import.owl
  
# remove dev, merge, annotated temp ontologies
# comment out these lines if you wish to examine them
rm osci-dev.owl
rm osci-merged.owl
rm osci-annotated.owl


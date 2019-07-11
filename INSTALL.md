# EPICO data model tools install

The tools needed to work with EPICO data model are in part included, but they depend on [BP Schema tools](https://github.com/inab/BP-Schema-tools).

Dependencies are listed at [cpanfile](cpanfile). Installing dependencies needed to work with the EPICO data model is done using [carton](https://metacpan.org/pod/Carton).

```bash
# This one installs Carton (in case you do not have it already)
cpan Carton
# This one installs the dependencies used by several programs
carton install --deployment --without develop
```

Now you should have a `local` directory, with all the scripts and needed tools.

You can test the installation running next commands:

```bash
# This command should create the file blueprint-model.bpmodel, which is
# a zip file with the data model and used ontologies
carton exec model-signer.pl blueprint-model.xml blueprint-model.bpmodel
unzip -l blueprint-model.bpmodel

# This command should rebuild the Gencode genes and transcrips ontologies
# You can check what has changed with git diff
carton exec ./Gencode2OBO.pl blueprint-model.xml GencodeGenes GencodeTranscripts
git diff cv
```
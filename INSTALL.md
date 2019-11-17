# EPICO data model tools install

The tools needed to work with EPICO data model are in part included, but they depend on [BP Schema tools](https://github.com/inab/BP-Schema-tools).

Dependencies are listed at [cpanfile](cpanfile). Some of those dependencies are available at [BSC INB DarkPAN](https://gitlab.bsc.es/inb/darkpan/).
The installation is done using [cpm](https://metacpan.org/pod/App::cpm), and the execution in the sandbox of dependencies with [Carton](https://metacpan.org/pod/Carton).

```bash
# This command is optional, but helps setting up a clean, healthy installation environment
eval $(perl -Mlocal::lib="$PWD/.plenv")
# Next command install both cpm and Carton (in case you do not have them already)
cpan App::cpm
# This one installs the dependencies used by several programs
cpm install --resolver 02packages,https://gitlab.bsc.es/inb/darkpan/raw/master/ --resolver metadb
# And optional last, deactivation of the clean installation environment
eval $(perl -Mlocal::lib=--deactivate,"$PWD/.plenv")
```

Now you should have a `local` directory, with all the scripts and needed tools from the dependencies.

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
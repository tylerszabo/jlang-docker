# J Language Dockerfile

A Dockerfile for building a runtime for the J interpreter.

Visit https://www.jsoftware.com/ to learn about the APL-inspired J language.

## Build

    docker build . --tag=tylerszabo/jlang

## Run

    docker run --rm -it tylerszabo/jlang

The above command will start an interactive `jconsole`. If you want to explore the image run with the following:

    docker run --rm -it tylerszabo/jlang sh

You can start the J runtime by running `jconsole` command.
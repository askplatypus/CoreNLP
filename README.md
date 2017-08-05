Stanford CoreNLP Docker image
=============================

This is a Docker image for the [CoreNLP](https://stanfordnlp.github.io/CoreNLP/index.html) [server](https://stanfordnlp.github.io/CoreNLP/corenlp-server.html) with all official models available.

## Build and run Docker file

```
git clone https://github.com/askplatypus/CoreNLP.git
cd CoreNLP
docker build . -t corenlp
```

This builds a docker image named corenlp. It contains a CoreNLP server listening to port 9000.

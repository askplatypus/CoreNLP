FROM openjdk:8

RUN mkdir /usr/src/app && \
    cd /usr/src/app && \
    wget http://nlp.stanford.edu/software/stanford-arabic-corenlp-2016-10-31-models.jar && \
    wget http://nlp.stanford.edu/software/stanford-chinese-corenlp-2016-10-31-models.jar && \
    wget http://nlp.stanford.edu/software/stanford-english-corenlp-2016-10-31-models.jar && \
    wget http://nlp.stanford.edu/software/stanford-english-kbp-corenlp-2016-10-31-models.jar && \
    wget http://nlp.stanford.edu/software/stanford-french-corenlp-2016-01-14-models.jar && \
    wget http://nlp.stanford.edu/software/stanford-german-corenlp-2016-10-31-models.jar && \
    wget http://nlp.stanford.edu/software/stanford-spanish-corenlp-2016-10-31-models.jar && \
    apt-get update && apt-get install -y --no-install-recommends ant

COPY . /usr/src/app

RUN cd /usr/src/app && \
    ant && \
    cd classes && \
    jar -cf ../stanford-corenlp.jar edu


ENV PORT 9000
EXPOSE $PORT

CMD java -cp "/usr/src/app/*;/usr/src/app/lib/*;/usr/src/app/liblocal/*" -Xmx10g edu.stanford.nlp.pipeline.StanfordCoreNLPServer

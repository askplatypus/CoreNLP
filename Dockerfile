# This dockerfile is inspired by https://github.com/motiz88/corenlp-docker/blob/master/Dockerfile

FROM openjdk:8-jre-alpine

RUN apk add --update --no-cache unzip wget
RUN wget http://nlp.stanford.edu/software/stanford-corenlp-full-2018-02-27.zip && \
    unzip stanford-corenlp-full-2018-02-27.zip && \
    rm stanford-corenlp-full-2018-02-27.zip && \
    cd stanford-corenlp-full-2018-02-27 && \
    wget http://nlp.stanford.edu/software/stanford-arabic-corenlp-2018-02-27-models.jar && \
    wget http://nlp.stanford.edu/software/stanford-chinese-corenlp-2018-02-27-models.jar && \
    wget http://nlp.stanford.edu/software/stanford-english-corenlp-2018-02-27-models.jar && \
    wget http://nlp.stanford.edu/software/stanford-english-kbp-corenlp-2018-02-27-models.jar && \
    wget http://nlp.stanford.edu/software/stanford-french-corenlp-2018-02-27-models.jar && \
    wget http://nlp.stanford.edu/software/stanford-german-corenlp-2018-02-27-models.jar && \
    wget http://nlp.stanford.edu/software/stanford-spanish-corenlp-2018-02-27-models.jar

ENV PORT 9000
EXPOSE $PORT

CMD java -cp "/stanford-corenlp-full-2018-02-27/*" -Xmx8g edu.stanford.nlp.pipeline.StanfordCoreNLPServer

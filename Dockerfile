# This dockerfile is inspired by https://github.com/motiz88/corenlp-docker/blob/master/Dockerfile

FROM openjdk:11-jre-slim

RUN apt-get update && apt-get -qq -y install wget unzip
RUN wget http://nlp.stanford.edu/software/stanford-corenlp-full-2018-10-05.zip && \
    unzip stanford-corenlp-full-2018-10-05.zip && \
    rm stanford-corenlp-full-2018-10-05.zip && \
    cd stanford-corenlp-full-2018-10-05 && \
    wget http://nlp.stanford.edu/software/stanford-arabic-corenlp-2018-10-05-models.jar && \
    wget http://nlp.stanford.edu/software/stanford-chinese-corenlp-2018-10-05-models.jar && \
    wget http://nlp.stanford.edu/software/stanford-english-corenlp-2018-10-05-models.jar && \
    wget http://nlp.stanford.edu/software/stanford-english-kbp-corenlp-2018-10-05-models.jar && \
    wget http://nlp.stanford.edu/software/stanford-french-corenlp-2018-10-05-models.jar && \
    wget http://nlp.stanford.edu/software/stanford-german-corenlp-2018-10-05-models.jar && \
    wget http://nlp.stanford.edu/software/stanford-spanish-corenlp-2018-10-05-models.jar

ENV PORT 9000
EXPOSE $PORT

CMD java -cp "/stanford-corenlp-full-2018-10-05/*" -Xmx8g edu.stanford.nlp.pipeline.StanfordCoreNLPServer --add-modules java.se.ee

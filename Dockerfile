FROM openjdk:8

RUN apt-get update && apt-get install -y --no-install-recommends ant

COPY . /usr/src/app

RUN cd /usr/src/app/ && \
    ant && \
    cd classes && \
    jar -cf ../stanford-corenlp.jar edu && \
    cd .. && \
    wget http://nlp.stanford.edu/software/stanford-english-corenlp-2016-10-31-models.jar && \
    wget http://nlp.stanford.edu/software/stanford-french-corenlp-2016-01-14-models.jar && \ 
    wget http://nlp.stanford.edu/software/stanford-german-corenlp-2016-10-31-models.jar


ENV PORT 9000
EXPOSE $PORT

CMD java -cp "/usr/src/app/*" -mx4g edu.stanford.nlp.pipeline.StanfordCoreNLPServer

FROM openjdk:8

COPY  *.jar lib liblocal /usr/src/corenlp/

ENV PORT 9000
EXPOSE $PORT

CMD java -cp "/usr/src/corenlp/*" -mx4g edu.stanford.nlp.pipeline.StanfordCoreNLPServer

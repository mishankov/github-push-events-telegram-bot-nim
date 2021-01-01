FROM nimlang/nim:1.4.2-alpine

COPY ./src /src

RUN nimble install jester -y 

RUN nim c -d:ssl -f:on -o:build/main src/main

CMD build/main

EXPOSE 5000

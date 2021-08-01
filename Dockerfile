FROM alpine:3.7
RUN apk update && \
    apk upgrade && \
    apk add && \
    apk add ca-certificates && \
    update-ca-certificates && \
    apk add openssl && \
    apk add openssh && \
    apk add unzip && \
    apk add --no-cache bash && \
    apk add --no-cache --virtual=build-dependencies unzip && \
    apk add --no-cache curl && \
    apk add --no-cache openjdk8 && \
    apk add git && \
    apk add maven && \
    apk add --no-cache nss

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk/jre
ENV PATH $PATH:$JAVA_HOME/bin

ENTRYPOINT mkdir ~/.ssh && \
    chmod 700 ~/.ssh && \
    ssh-keyscan -t rsa github.com > ~/.ssh/known_hosts && \
    git clone https://github.com/isa-group/RESTest.git && \
    cd RESTest && \
    ./scripts/install_dependencies.sh && \
    mvn clean install -DskipTests && \
    java -jar target/restest-full.jar src/test/resources/Bikewise/bikewise.properties
    #java -jar restest.jar src/test/resources/Folder/api.properties

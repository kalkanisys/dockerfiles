FROM openjdk:11-jre

ENV NODEJS_VERSION 10.16.0
ENV SONAR_SCANNER_VERSION 4.0.0.1744
ENV SONARDIR /var/opt/sonar-scanner-${SONAR_SCANNER_VERSION}-linux
ENV SONARBIN ${SONARDIR}/bin/sonar-scanner

LABEL in.kalkani.sonar-scanner_version=${SONAR_SCANNER_VERSION}

RUN \
    cd /usr/ && \
    curl https://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}-linux-x64.tar.xz --output node-v${NODEJS_VERSION}-linux-x64.tar.xz && \
    tar --strip-components=1 -xvf node-v${NODEJS_VERSION}-linux-x64.tar.xz && \
    rm node-v${NODEJS_VERSION}-linux-x64.tar.xz

RUN npm install -g typescript

RUN \
    cd /var/opt && \
    curl https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip --output /var/opt/sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip && \
    unzip sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip && \
    rm sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux.zip && \
    rm -rf ${SONARDIR}/jre && \
    sed -i -e 's/use_embedded_jre=true/use_embedded_jre=false/' ${SONARBIN} ${SONARBIN}-debug && \
    ln -s ${SONARBIN} /usr/bin/sonar-scanner

WORKDIR /usr/bin

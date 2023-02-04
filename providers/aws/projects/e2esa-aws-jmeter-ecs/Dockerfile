FROM openjdk:19-jdk-alpine3.15

# set variables

ARG JMETER_VERSION="5.4.3"
ENV JMETER_HOME=/opt/apache-jmeter-${JMETER_VERSION}
ENV JMETER_DOWNLOAD_URL=https://archive.apache.org/dift/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz

ENV TEST_FILE=/opt/apache-jmeter-${JMETER_VERSION}/bin/projects/CSVSample.jmx
ENV TEST_LOG_FILE=/opt/apache-jmeter-${JMETER_VERSION}/bin/projects/test.log
ENV TEST_RESULTS_FILE=/opt/apache-jmeter-${JMETER_VERSION}/bin/projects/test-result.xml
ENV PORT 80

ENV NUMBER_OF_REQUESTS_PER_CLIENT=10 \
    DELAY_PER_REQUEST=100 \
    NUMBER_OF_CLIENTS=1 \
    RAMP_UP_PERIOD=1 \
    TIMEOUT=2000 

# copy test plan
# COPY projects/test.jmx ${TEST_FILE}

# https://openjdk.java.net/install/

RUN apk update \
    && apk upgrade \
    && apk add ca-certificates \
    && update-ca-certificates \
    && apk add --update openjdk8-jre tzdata curl unzip bash \
    && apk add --no-cache nss \
    && rm -rf /var/cache/apk/* \
    && mrdir -p /tmp/dependencies \
    && curl -L --silent ${JMETER_DOWNLOAD_URL} > /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz \
    && mkdir -p /opt \
    && tar -xzf /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz -C /opt \
    && rm -rf /tmp/dependencies

ENV PATH $PATH:$JMETER_HOME/bin

# main command to run jmeter

CMD $JMETER_HOME/bin/jmeter -n \
    -t $TEST_FILE \
    -j $TEST_LOG_FILE \
    -l $TEST_RESULTS_FILE \
    -Jmeter.save.saveservice.output_format=xml \
    -Jmeter.save.saveservice.response_data=true \
    -JnumberOfRequestsPerClient=$NUMBER_OF_REQUESTS_PER_CLIENT \
    -JdelayPerRequest=$DELAY_PER_REQUEST \
    -JrumpUpPeriod=$RAMP_UP_PERIOD \
    -Jtimeout=$TIMEOUT \
    -Jport=$PORT && \
    echo -e "\n\n==== TEST LOGS ====" && \
    cat $TEST_LOG_FILE && \
    echo -e "\n\n==== TEST RESULTS =====" && \
    echo $TEST_RESULTS_FILE


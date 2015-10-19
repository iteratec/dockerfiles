FROM rounds/10m-python
MAINTAINER Birger Kamp <Birger.Kamp@iteratec.de>

ENV RULES_FOLDER /elastalert/elastalert_rules
ENV RUN_EVERY_MINUTES 5
ENV BUFFER_TIME_MINUTES 45
ENV ELASTICSEARCH_HOST elasticsearch.example.com
ENV ELASTICSEARCH_PORT 14900
ENV ALERT_TIME_LIMIT_DAYS 2

RUN apt-get update && \
    apt-get install -y git python-dev

# install elastalert
RUN pip install -U pip
RUN git clone https://github.com/Yelp/elastalert.git

WORKDIR elastalert

RUN pip install -r requirements.txt

COPY conf/config.yaml ./

VOLUME $RULES_FOLDER

CMD python -m elastalert.elastalert --verbose --rule example_frequency.yaml

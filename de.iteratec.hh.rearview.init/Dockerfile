FROM mysql:5.5
MAINTAINER Nils Kuhn <nils.kuhn@iteratec.de>

COPY initialization.sh /tmp/initialization.sh
RUN chmod a+x /tmp/initialization.sh

ENTRYPOINT /tmp/initialization.sh
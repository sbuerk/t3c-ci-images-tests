FROM httpd:2.4-alpine
LABEL org.opencontainers.image.authors="Christian Kuhn <lolli@schwarzbu.ch> and Stefan Bürk <stefan@buerk.tech>"
LABEL org.opencontainers.image.source=https://git.typo3.org/typo3/CI/testing-infrastructure
LABEL org.opencontainers.image.url=https://git.typo3.org/typo3/CI/testing-infrastructure/-/blob/main/docker-images/README.md
LABEL org.opencontainers.image.description="sbuerk/test1-core-testing-apache"

#FROM ubuntu/apache2:2.4-22.04_beta

RUN printf "Include conf/custom.conf\n" >> /usr/local/apache2/conf/httpd.conf

COPY httpd-foreground /usr/local/bin/
COPY custom.conf /usr/local/apache2/conf/custom.conf

CMD ["httpd-foreground"]


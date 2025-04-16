FROM ibmcom/db2:11.5.8.0

RUN mkdir /var/custom
COPY createschema.sh /var/custom
RUN chmod a+x /var/custom/createschema.sh

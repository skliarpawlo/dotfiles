FROM pavlo/spacemacs:2.0

WORKDIR /code

ARG SUBDIR
COPY .git /code/.git
RUN git config core.sparseCheckout true
RUN echo "${SUBDIR}/*" > .git/info/sparse-checkout
RUN git checkout master && git reset --hard origin/master

RUN pip3.5 install -r /code/${SUBDIR}/requirements.txt
RUN pip3.5 install -r /code/${SUBDIR}/requirements_dev.txt; exit 0
COPY .ssh /root/.ssh

# AVRO
RUN echo "deb http://archive.tubularlabs.net/apt/ unstable/" > /etc/apt/sources.list.d/tubular.unstable.list
RUN apt-get update && apt-get -y --force-yes install avro-tools tubular-libavro

###############
# ENTRY POINT
###############
COPY init.sh /opt/init.sh
ENTRYPOINT ["/opt/init.sh"]

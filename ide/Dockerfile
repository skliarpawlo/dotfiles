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

###############
# ENTRY POINT
###############
COPY init.sh /opt/init.sh

ENV PYTHONPATH $PYTHONPATH:/code/${SUBDIR}:/code/${SUBDIR}/src
ENV TUBULAR_SETTINGS_ENV test

ENTRYPOINT ["/opt/init.sh"]

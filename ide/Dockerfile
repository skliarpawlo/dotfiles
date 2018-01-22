FROM pavlo/spacemacs:2.0

WORKDIR /code

ARG SUBDIR
COPY .git /code/.git
RUN git config core.sparseCheckout true
RUN echo "${SUBDIR}/*" > .git/info/sparse-checkout
RUN git checkout master && git reset --hard origin/master

RUN pip3.5 install -r /code/${SUBDIR}/requirements.txt
RUN pip3.5 install -r /code/${SUBDIR}/requirements_dev.txt
COPY .ssh /root/.ssh

FROM pavlo/spacemacs:1.0

ARG SUBDIR
COPY --chown=spacemacser:emacs .git /mnt/workspace/.git
RUN sudo su spacemacser -c "git config core.sparseCheckout true"
RUN sudo su spacemacser -c "echo "${SUBDIR}/*" > .git/info/sparse-checkout"
RUN sudo su spacemacser -c "git checkout master && git reset --hard origin/master"

RUN pip3.5 install -r /mnt/workspace/${SUBDIR}/requirements.txt
RUN pip3.5 install -r /mnt/workspace/${SUBDIR}/requirements_dev.txt


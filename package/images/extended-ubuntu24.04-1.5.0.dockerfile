FROM docker.io/spectralcompute/scale:13.0.2-devel-ubuntu24.04-1.5.0

ENV DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-c"]

COPY installDeps.sh /tmp/installDeps.sh

# apparently can't have a HEREDOC in older docker

RUN chmod +x /tmp/installDeps.sh && /tmp/installDeps.sh && rm /tmp/installDeps.sh

ADD run-validation.sh /root/run-validation.sh


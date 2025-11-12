FROM ubuntu:22.04
ENV PATH="/root/miniforge3/bin:${PATH}"
ARG PATH="/root/miniforge3/bin:${PATH}"
RUN apt-get update
RUN apt-get install -y wget && rm -rf /var/lib/apt/lists/*

# install miniforge
RUN wget \
    https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniforge3-Linux-x86_64.sh -b \
    && rm -f Miniforge3-Linux-x86_64.sh \
RUN conda --version

LABEL "repository"="https://github.com/paulscherrerinstitute/conda-publish-action"
LABEL "maintainer"="paulscherrerinstitute"

RUN conda install -y anaconda-client conda-build conda-verify

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    python3 \
    python3-pip \
    build-essential \
    libssl-dev \
    libcurl3-dev \
    python-opencv \
    curl \
    git \
    sudo \
    libxml2-dev && \
    pip3 install bash_kernel && \
    pip3 install --upgrade streamlit && \
    pip3 install --upgrade opencv-python && \
    mkdir -p /home/streamlit \
    mkdir -p /home/streamlit/images


ENV PATH="/bin:/usr/bin/:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/home/streamlit/.local/bin"
WORKDIR /home/streamlit
ENV HOME="/home/streamlit"
EXPOSE 8501
COPY entrypoint /usr/local/bin/entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint"]
CMD ["streamlit", "run"]
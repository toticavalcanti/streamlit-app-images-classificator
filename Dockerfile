FROM ubuntu:latest

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    mkdir streamlit \
    python3 \
    python3-pip \
    build-essential \
    libssl-dev \
    libcurl3-dev \
    curl \
    git \
    sudo \
    libxml2-dev && \
    pip3 install streamlit \
    pip3 install bash_kernel && \
    pip3 install --upgrade streamlit && \
    pip3 install --upgrade opencv-python && \
    pip3 install -r requirements.txt

ENV PATH="/bin:/usr/bin/:/sbin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/home/streamlit/.local/bin"
WORKDIR /home/streamlit
ENV HOME="/home/streamlit"
EXPOSE 8501
COPY entrypoint /usr/local/bin/entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint"]
CMD ["streamlit", "run"]
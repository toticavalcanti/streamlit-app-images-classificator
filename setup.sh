mkdir -p ~/.streamlit/
RUN apt update
RUN apt -y install build-essential libwrap0-dev libssl-dev libc-ares-dev uuid-dev xsltproc
RUN apt-get update -qq \
    && apt-get install --no-install-recommends --yes \
        build-essential \
        gcc \
        python3-dev \
        mosquitto \
        mosquitto-clients


RUN pip3 install --upgrade pip setuptools wheel

RUN python3 -m pip install --no-cache-dir \
      numpy scipy matplotlib scikit-build opencv-contrib-python-headless \
      influxdb paho-mqtt configparser Pillow \
      qrcode
echo "\
[server]\n\
headless = true\n\
port = $PORT\n\
enableCORS = false\n\
\n\
" > ~/.streamlit/config.toml
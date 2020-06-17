# kaggleのpython環境をベースにする
FROM gcr.io/kaggle-gpu-images/python:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
    libblas-dev \
	liblapack-dev\
    libatlas-base-dev \
    mecab \
    mecab-naist-jdic \
    mecab-ipadic-utf8 \
    swig \
    libmecab-dev \
	gfortran \
    sudo \
    cmake \
    python3-setuptools

# mecab-ipadic-neologd install
WORKDIR /opt
RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git
WORKDIR /opt/mecab-ipadic-neologd
RUN ./bin/install-mecab-ipadic-neologd -n -y
WORKDIR /opt
RUN rm -rf mecab-ipadic-neologd

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*
# ライブラリの追加インストール
RUN pip install -U pip && \
    pip install fastprogress japanize-matplotlib hydra-core --upgrade --pre mlflow
RUN export LD_LIBRARY_PATH=/usr/local/cuda/lib64
EXPOSE 8888
EXPOSE 5000
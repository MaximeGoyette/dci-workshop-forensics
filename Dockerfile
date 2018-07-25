FROM ubuntu:xenial

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y  binwalk \
    foremost \
    exiftool \
    build-essential \
    libssl-dev \
    git \
    yasm \
    libgmp-dev \
    libpcap-dev \
    pkg-config \
    libbz2-dev \
    wget \
    tshark \
    volatility \
    python3-pip

RUN pip3 install pyshark scapy

WORKDIR /tools
RUN git clone https://github.com/magnumripper/JohnTheRipper.git

WORKDIR /tools/JohnTheRipper/src
RUN ./configure && make -s clean && make -sj4

WORKDIR /tools
RUN wget http://downloads.skullsecurity.org/passwords/rockyou.txt.bz2 && bzip2 -d rockyou.txt.bz2

WORKDIR /challenges
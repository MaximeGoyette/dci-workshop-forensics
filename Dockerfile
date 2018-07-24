FROM ubuntu:xenial

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt -y full-upgrade
RUN apt install -y  binwalk \
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
                    tshark

WORKDIR /tools
RUN git clone https://github.com/magnumripper/JohnTheRipper.git

WORKDIR /tools/JohnTheRipper/src
RUN ./configure && make -s clean && make -sj4
ENV PATH="$PATH:/tools/JohnTheRipper/run"

WORKDIR /tools
RUN wget http://downloads.skullsecurity.org/passwords/rockyou.txt.bz2
RUN bzip2 -d rockyou.txt.bz2

WORKDIR /challenges
FROM ubuntu:xenial

COPY challenges /challenges

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="$PATH:/tools/JohnTheRipper/run"

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

WORKDIR /tools/JohnTheRipper/run
RUN export PATH=$(pwd):$PATH

WORKDIR /tools
RUN wget http://downloads.skullsecurity.org/passwords/rockyou.txt.bz2
RUN bzip2 -d rockyou.txt.bz2

RUN wget https://www.unix-ag.uni-kl.de/~conrad/krypto/pkcrack/pkcrack-1.2.2.tar.gz
RUN tar -xzf pkcrack-1.2.2.tar.gz && rm pkcrack-1.2.2.tar.gz

WORKDIR /tools/pkcrack-1.2.2/src
RUN make

WORKDIR /challenges
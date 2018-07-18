FROM ubuntu:xenial

COPY challenges /challenges

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

WORKDIR /tools
RUN wget https://www.unix-ag.uni-kl.de/~conrad/krypto/pkcrack/pkcrack-1.2.2.tar.gz
RUN tar -xzf pkcrack-1.2.2.tar.gz && rm pkcrack-1.2.2.tar.gz

WORKDIR /tools/pkcrack-1.2.2/src
RUN make
ENV PATH="$PATH:/tools/pkcrack-1.2.2/src"

WORKDIR /challenges
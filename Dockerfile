FROM ubuntu:xenial
MAINTAINER maxgoyette0@gmail.com

ENV TERM xterm-256color

RUN apt update && apt full-upgrade -y
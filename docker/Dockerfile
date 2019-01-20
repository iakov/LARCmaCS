FROM ubuntu:xenial
ENV DEBIAN_FRONEND noninteractive
RUN apt update
RUN apt full-upgrade -y
ADD ./larcmacs_depenendencies.tar.xz /usr/local/MATLAB

#Install build dependencies
RUN apt install -y build-essential qt5-default libprotobuf-dev protobuf-compiler libunwind-dev

#Put here additional helpers
RUN apt install -y bash-completion

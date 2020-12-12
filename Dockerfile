FROM ubuntu:20.04

RUN apt install curl bash

COPY LICENSE README.md /

COPY tools/ /tools/
COPY build.sh /build.sh
RUN /build.sh
RUN rm -rf /tools /build.sh

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

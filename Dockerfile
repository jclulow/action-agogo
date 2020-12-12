FROM alpine:3.10

COPY LICENSE README.md /

COPY tools/ /tools/
COPY build.sh /build.sh
RUN ls -la /
RUN /build.sh
RUN rm -rf /tools /build.sh

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

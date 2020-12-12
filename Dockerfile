FROM alpine:3.10

RUN apk --no-cache add curl
RUN apk --no-cache add bash

COPY LICENSE README.md /

COPY tools/ /tools/
COPY build.sh /build.sh
RUN /build.sh
RUN rm -rf /tools /build.sh

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

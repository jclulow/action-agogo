FROM ubuntu:20.04

RUN apt-get -y -q update && apt-get -y -q install curl bash build-essential

COPY LICENSE README.md /

COPY tools/ /tools/
COPY build.sh /build.sh
RUN /build.sh

FROM ubuntu:20.04
COPY --from=0 /tools/target/release/agogo /usr/bin/agogo
ENTRYPOINT ["/usr/bin/agogo"]

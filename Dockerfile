FROM ubuntu:20.04

RUN apt-get -y -q update && apt-get -y -q install curl bash build-essential

ENV RUSTUP_HOME=/rustup
ENV CARGO_HOME=/rustup

#
# Install latest stable Rust
#
RUN curl -sSf https://sh.rustup.rs | bash -s -- \
    -y \
    --default-toolchain stable \
    --no-modify-path

ENV PATH=$CARGO_HOME/bin:$PATH

COPY tools/ /tools/
RUN cd /tools && /rustup/bin/cargo build --release

#
# Grab prebuilt buildomat client
#
ADD https://sysmgr.org/buildomat/client.linux /tools/buildomat-client
RUN chmod +rx /tools/buildomat-client

FROM ubuntu:20.04
RUN apt-get -y -q update && apt-get -y dist-upgrade && \
    apt-get -y install ca-certificates
COPY --from=0 /tools/target/release/agogo /usr/bin/agogo
COPY --from=0 /tools/buildomat-client /usr/bin/buildomat-client
ENTRYPOINT ["/usr/bin/agogo"]

#!/bin/sh

set -o xtrace
set -o errexit
set -o pipefail

export RUSTUP_HOME=/rustup
export CARGO_HOME=$RUSTUP_HOME

curl -sSf https://sh.rustup.rs | sh -s -- \
    -y \
    --default-toolchain stable \
    --no-modify-path

export PATH="$CARGO_HOME/bin:$PATH"

cd /tools
cargo build --release

mv /tools/target/release/agogo /usr/bin/agogo

rm -rf /rustup

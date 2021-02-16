use anyhow::{anyhow, bail, Result};
use std::process::Command;
use std::os::unix::process::CommandExt;

fn getenv(n: &str) -> Result<String> {
    std::env::var(n).map_err(|e| anyhow!("env var {}: {:?}", n, e))
}

fn main() -> Result<()> {
    println!("ENVIRONMENT:");
    for (k, v) in std::env::vars() {
        println!("{} = \"{}\"", k, v);
    }

    let name = ["REPOSITORY", "WORKFLOW", "JOB", "RUN_NUMBER"].iter()
        .map(|s| getenv(&format!("GITHUB_{}", s)))
        .collect::<Result<Vec<String>, _>>()?
        .join(":");

    let mut script = String::new();
    script += "set -o errexit\n";
    script += "set -o pipefail\n";
    script += "pkg install -q git\n";
    script += &format!("mkdir -p '{}'\n", getenv("GITHUB_WORKSPACE")?);
    script += &format!("cd '{}'\n", getenv("GITHUB_WORKSPACE")?);
    script += &format!("git clone '{}/{}.git'\n",
        getenv("GITHUB_SERVER_URL")?, getenv("GITHUB_REPOSITORY")?);
    script += &format!("git fetch origin '{}'\n", getenv("GITHUB_SHA")?);
    script += "git checkout FETCH_HEAD\n";
    script += &getenv("INPUT_SCRIPT")?;

    println!("name: {:#?}", name);
    println!("script: {:#?}", script);

    Command::new("/usr/bin/buildomat-client")
        .arg(name)
        .arg(script)
        .exec();

    bail!("exec failed");
}

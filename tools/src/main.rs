use std::process::exit;
use anyhow::{Context, Result};

fn main() -> Result<()> {
    println!("WELCOME TO ACTION AGOGO, VERSION 1! COLOUR: {}",
        std::env::args().nth(1).as_deref().unwrap_or("none?!"));
    println!("ENVIRONMENT:");
    for (k, v) in std::env::vars() {
        println!("{} = \"{}\"", k, v);
    }

    let script = std::env::var("INPUT_SCRIPT").context("read INPUT_SCRIPT")?;

    println!("script: {:#?}", script.lines().collect::<Vec<_>>());

    exit(0);
}

use std::process::exit;

fn main() {
    println!("WELCOME TO ACTION AGOGO, VERSION 1!");
    println!("ENVIRONMENT:");
    for (k, v) in std::env::vars() {
        println!("{} = \"{}\"", k, v);
    }
    exit(1);
}

use std::process::exit;

fn main() {
    println!("WELCOME TO ACTION AGOGO, VERSION 1! COLOUR: {}",
        std::env::args().nth(1).as_deref().unwrap_or("none?!"));
    println!("ENVIRONMENT:");
    for (k, v) in std::env::vars() {
        println!("{} = \"{}\"", k, v);
    }
    exit(0);
}

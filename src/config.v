module main

pub struct Config {
pub mut:
	mod_key int = 64
}

pub fn new_config() Config {
	return Config{}
}

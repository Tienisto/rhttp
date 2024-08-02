use crate::frb_generated::StreamSink;
use anyhow::Result;
use std::thread::sleep;
use std::time::Duration;

#[flutter_rust_bridge::frb(sync)] // Synchronous mode for simplicity of the demo
pub fn greet(name: String) -> String {
    format!("Hello, {name}!")
}

const ONE_SECOND: Duration = Duration::from_secs(1);

// can't omit the return type yet, this is a bug
pub fn tick(sink: StreamSink<i32>) -> Result<()> {
    let mut ticks = 0;
    loop {
        sink.add(ticks).expect("Failed to send tick");
        sleep(ONE_SECOND);
        if ticks == i32::MAX {
            break;
        }
        ticks += 1;
    }
    Ok(())
}

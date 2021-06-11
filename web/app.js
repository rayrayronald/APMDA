let text;
let port;
let reader;
let inputDone;
let outputDone;
let inputStream;
let outputStream;

window.state = {
    value: null,
    connected: false
}

function getter(key) {
    return window.state[key];
}

function chrome_ble() {
navigator.bluetooth.requestDevice({
  acceptAllDevices: true,
})
.then(device => {
        // Human-readable name of the device.
        console.log(device.name);

        // Attempts to connect to remote GATT Server.
        return device.gatt.connect();
      })
.catch(error => {    alert(error)
});
}


async function chrome_serial() {
disconnect()
try {
port = await navigator.serial.requestPort();
// - Wait for the port to open.
await port.open({ baudRate: 9600 });
} catch (error) {
    alert(error)
} finally {
state['connected'] = true;
const reader = port.readable.getReader();

// Listen to data coming from the serial device.
while (true) {
  const { value, done } = await reader.read();
  if (done) {
    // Allow the serial port to be closed later.
    reader.releaseLock();
    break;
  }
    if (value) {
      state['value'] = value;
      alert(value);
    }
}
}

}

async function disconnect() {
state['connected'] = false;
if (reader) {
  await reader.cancel();
  await inputDone.catch(() => {});
  reader = null;
  inputDone = null;
}
await port.close();
port = null;
}


function alertMessage(text) {
    alert(text)
}

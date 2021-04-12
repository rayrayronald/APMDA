function chrome_ble() {

navigator.bluetooth.requestDevice({
  acceptAllDevices: true,
})
.then(device => { /* … */ })
.catch(error => { console.error(error); });
}

async function chrome_serial() {
port = await navigator.serial.requestPort();
// - Wait for the port to open.
await port.open({ baudate: 9600 });


// CODELAB: Add code to read the stream here.
let decoder = new TextDecoderStream();
inputDone = port.readable.pipeTo(decoder.writable);
inputStream = decoder.readable.pipeThrough(new TransformStream(new LineBreakTransformer()));

reader = inputStream.getReader();
readLoop();
}

async function readLoop() {
// CODELAB: Add read loop here.
    while (true) {
      const { value, done } = await reader.read();
      if (value) {
        log.textContent += value + '\n';
      }
      if (done) {
        console.log('[readLoop] DONE', done);
        reader.releaseLock();
        break;
      }
    }
}

class LineBreakTransformer {
  constructor() {
    // A container for holding stream data until a new line.
    this.container = '';
  }

  transform(chunk, controller) {
    // CODELAB: Handle incoming chunk
    this.container += chunk;
    const lines = this.container.split('\r\n');
    this.container = lines.pop();
    lines.forEach(line => controller.enqueue(line));

  }

  flush(controller) {
    // CODELAB: Flush the stream.
    controller.enqueue(this.container);

  }
}
function alertMessage(text) {
    alert(text)
}

//----1---//
function connectDevice() {
ConnectBLE.postMessage('ble.connect');
}
//----2---//
function receiveDeviceStatus(text){
console.log('*** Update Device Status ***');
}
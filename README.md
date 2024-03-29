# Universal Wireless Sensor Monitoring Application

## Recommended Installations and Tools
- Android Studio with Dart & Flutter PLugins
- Flutter SDK
- Android Virtual Device & xcode with iphone simulator
- Firebase SDK
- JDK (JDK 16 not supportted at the moment of writing)

## Dart files

### main.dart
- Initalisation of the application
- Firebase.initializeApp() initiates connection with the set Firebase account
- Android and iOS login credentials are downlaoded from Firebase Console
- Web login credentials are in web/index.html

### LoginScreen.dart
- Verifies log in credentials with data on corresponding Firebase Users records
- Currently configured to automatically enter credentials as set in CONSTANTS.dart

### PatientScreen.dart
- Retrieves list of patients from Firebase and their sensor connection status
- Connection status is manually hard coded currently
- Consists of simulator sensors that generator sine wave with noise
#### Sensors
#####  Chrome Web Bluetooth API
- Only work in Chrome browser with experimental features enabled
- Javascript written in /web/app.js
- Custom Data parsing needs to be updated

#####  Chrome Web Serial API
- Only work in Desktop Chrome browser with experimental features enabled
- Javascript written in /web/app.js
- Custom Data parsing needs to be updated

#####  flutter_bluetooth_serial
- Not supportted on iOS devices
- modify processByte() to change data processing
- Be aware of Big Endian & Small Endian!!

#####  flutter_blue
- Custom Data parsing needs to be updated


### HistoryScreen.dart
- Retrieves list of recording data from Firebase
- Selected data could be a continously updated stream

### ChartScreen.dart
- Displays pseudo / sensor data in the form of a interactive chart
- Chooses data processing type based on document_name, connection and sensor arguments passed on from previous screen







## Potential Bugs and fixes

CanvasKit memory leak

When the exception was thrown, this was the stack:  https://unpkg.com/canvaskit-wasm@0.24.0/bin/canvaskit.js 150:56              Ma https://unpkg.com/canvaskit-wasm@0.24.0/bin/canvaskit.js 220:103             d https://unpkg.com/canvaskit-wasm@0.24.0/bin/canvaskit.js 1:1                 Paragraph$layout lib/_engine/engine/canvaskit/text.dart 572:18                                layout packages/flutter/src/painting/text_painter.dart 578:5                        layout

Solution: run with --web-renderer html to forcefully choose html over CanvasKit

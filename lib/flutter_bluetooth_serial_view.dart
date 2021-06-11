import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:my_app/UI/MyDrawer.dart';
import 'package:my_app/Tools/helper.dart';
import 'package:my_app/flutter_reactive_ble.dart';
import 'package:my_app/serial_data.dart';
import 'Tools/User.dart';
import 'Tools/helper.dart';
import 'UI/MyAppBar.dart';
import 'UI/MyDrawer.dart';
import './read.dart';
import './Testing.dart';
import './data.dart';
import './history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_blue/flutter_blue.dart';
import 'dart:convert';
import 'package:my_app/bundler/stub_js.dart' if (dart.library.js) 'dart:js' as js;
// import 'dart:js' as js;


class flutter_bluetooth_serial_view extends StatefulWidget {
  final User user;
  final String patient;
  final DocumentReference reference;

  flutter_bluetooth_serial_view({@required this.user, @required this.patient, @required this.reference});

  @override
  State createState() {
    return _flutter_bluetooth_serial_view(this.user, this.patient, this.reference);
  }
}

class _flutter_bluetooth_serial_view extends State<flutter_bluetooth_serial_view> {
  final User user;
  final String patient;
  final DocumentReference reference;

  _flutter_bluetooth_serial_view(this.user, this.patient, this.reference);

  // Initializing the Bluetooth connection state to be unknown
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  // Initializing a global key for SnackBar
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // Get the instance of the Bluetooth
  FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  // Track the Bluetooth connection with the remote device
  BluetoothConnection connection;

  int _deviceState;

  bool isDisconnecting = false;

  int bytePackage = 0;
  Uint8List byteBuffer = Uint8List(4);


  // To track whether the device is still connected to Bluetooth
  bool get isConnected => connection != null && connection.isConnected;

  // Define some variables, which will be required later
  List<BluetoothDevice> _devicesList = [];
  BluetoothDevice _device;
  bool _connected = false;
  bool _isButtonUnavailable = false;
  String _deviceName;

  String fromSerial = getFromJS("value");

  // List<_MeasuredData> data = [];


  @override
  void initState() {
    super.initState();

    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    _deviceState = 0; // neutral

    // If the bluetooth of the device is not enabled,
    // then request permission to turn on bluetooth
    // as the app starts up
    enableBluetooth();

    // Listen for further state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
        if (_bluetoothState == BluetoothState.STATE_OFF) {
          _isButtonUnavailable = true;
        }
        getPairedDevices();
      });
    });
  }

  @override
  void dispose() {
    // Avoid memory leak and disconnect
    // if (isConnected) {
    //   isDisconnecting = true;
    //   connection.dispose();
    //   connection = null;
    // }

    super.dispose();
  }

  // Request Bluetooth permission from the user
  Future<void> enableBluetooth() async {
    // Retrieving the current Bluetooth state
    _bluetoothState = await FlutterBluetoothSerial.instance.state;

    // If the bluetooth is off, then turn it on first
    // and then retrieve the devices that are paired.
    if (_bluetoothState == BluetoothState.STATE_OFF) {
      await FlutterBluetoothSerial.instance.requestEnable();
      await getPairedDevices();
      return true;
    } else {
      await getPairedDevices();
    }
    return false;
  }

  // For retrieving and storing the paired devices
  // in a list.
  Future<void> getPairedDevices() async {
    List<BluetoothDevice> devices = [];

    // To get the list of paired devices
    try {
      devices = await _bluetooth.getBondedDevices();
    } on PlatformException {
      print("Error");
    }

    // It is an error to call [setState] unless [mounted] is true.
    if (!mounted) {
      return;
    }

    // Store the [devices] list in the [_devicesList] for accessing
    // the list outside this class
    setState(() {
      _devicesList = devices;
    });
  }

  // Now, its time to build the UI
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Select Sensor"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            iconSize: 20.0,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.blue,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              label: Text(
                "Refresh",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              splashColor: Colors.grey,
              onPressed: () async {
                // So, that when new devices are paired
                // while the app is running, user can refresh
                // the paired devices list.
                await getPairedDevices().then((_) {
                  show(context, 'Device list refreshed');
                });
              },
            ),
          ],
        ),
        body: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Visibility(
                visible: _isButtonUnavailable &&
                    _bluetoothState == BluetoothState.STATE_ON,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.blue,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Enable Bluetooth',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Switch(
                      value: _bluetoothState.isEnabled,
                      onChanged: (bool value) {
                        future() async {
                          if (value) {
                            await FlutterBluetoothSerial.instance
                                .requestEnable();
                          } else {
                            await FlutterBluetoothSerial.instance
                                .requestDisable();
                          }

                          await getPairedDevices();
                          _isButtonUnavailable = false;

                          if (_connected) {
                            _disconnect();
                          }
                        }

                        future().then((_) {
                          setState(() {});
                        });
                      },
                    )
                  ],
                ),
              ),
              Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              js.context.callMethod("test") ?? "Select Sensor",
                              style: TextStyle(fontSize: 24, color: Colors.blue),
                              textAlign: TextAlign.center,
                            ),
                            RaisedButton(
                              elevation: 2,
                              child: Text("Bluetooth Settings"),
                              onPressed: () {
                                FlutterBluetoothSerial.instance.openSettings();
                              },
                            ),
                          ],
                        )
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Device:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            DropdownButton(
                              items: _getDeviceItems(),
                              onChanged: (value) =>
                                  setState(() => _device = value),
                              value: _devicesList.isNotEmpty ? _device : null,
                            ),
                            RaisedButton(
                              onPressed: _isButtonUnavailable
                                  ? null
                                  : _connected ? _disconnect : _connect,
                              child:
                              Text(_connected ? 'Disconnect' : 'Connect'),
                            ),
                          ],
                        ),
                      ),
                      RaisedButton(
                        child: Text("See graph"),
                        onPressed: () {
                          print (_device.toString());
                          print (_device.type);
                          if (_device.address == null) {
                            // push(context, data(user: user, patient: patient, reference: reference, sensor: _device.name));
                            show(context, "Choose a connected bluetooth serial device.");

                          // } else if (js.JsObject.fromBrowserObject(js.context['state'])['connected']){
                          //   push(context, serial_data(user: user, patient: patient, reference: reference, sensor: _device.name, connection: null));

                          } else {
                            push(context, serial_data(user: user, patient: patient, reference: reference, sensor: _device.name, connection: connection));
                          }
                        },
                      ),
                      Text(fromSerial ?? " "),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Create the List of devices to be shown in Dropdown Menu
  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    // items.add(DropdownMenuItem(
    //   child: Text("SPO2 random data"),
    //   value: new BluetoothDevice(name: "SPO2")
    // ));
    // items.add(DropdownMenuItem(
    //     child: Text("Serial"),
    //     value: new BluetoothDevice(name: "Serial")
    // ));
    // items.add(DropdownMenuItem(
    //     child: Text("Blood Glucose random data"),
    //     value: new BluetoothDevice(name: "Blood Glucose")
    // ));
    if (_devicesList.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      _devicesList.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name),
          value: device,
        ));
      });
    }
    return items;
  }

  // Method to connect to bluetooth
  void _connect() async {
    setState(() {
      _isButtonUnavailable = true;
    });
    if (_device == null) {
      show(context, 'No device selected');
    } else if (_device.address == null){
      reference.update({'sensor_connected': true});
      reference.update({'sensor_chosen': _device.name});

    } else {
      if (!isConnected) {
        await BluetoothConnection.toAddress(_device.address)
            .then((_connection) {
          print('Connected to the device');
          connection = _connection;
          setState(() {
            _connected = true;
          });
          reference.update({'sensor_connected': true});
          reference.update({'sensor_chosen': _device.name});
          try {

          }
          catch (exception) {
            print('Cannot connect, exception occured');
          }

          // connection.input.listen(null).onDone(() {
          //   if (isDisconnecting) {
          //     print('Disconnecting locally!');
          //   } else {
          //     print('Disconnected remotely!');
          //   }
          //   if (this.mounted) {
          //     setState(() {});
          //   }
          // });
        }).catchError((error) {
          print('Cannot connect, exception occurred');
          print(error);
        });
        show(context, 'Device connected');

        setState(() => _isButtonUnavailable = false);
      }
    }
  }

  void processByte(Uint8List data) async {
    for (int i = 0; i < data.length; i++) {
      byteBuffer[bytePackage] = data[i];
      bytePackage++;
      // print(bytePackage);

      if (bytePackage == 4) {
        // print(Endian.host == Endian.little);
        bytePackage = 0;

        ByteData byteData = ByteData.sublistView(byteBuffer);
        print("Channel 1: " + byteData.getUint16(0, Endian.big).toString() + " Channel 2: " + byteData.getUint16(2, Endian.big).toString());
        // Uint16List sixteenBitList = byteBuffer.buffer.asUint16List();
        // print(sixteenBitList);

      }
    }
  }

  // Method to disconnect bluetooth
  void _disconnect() async {
    setState(() {
      _isButtonUnavailable = true;
      _deviceState = 0;
    });

    await connection.close();
    show(context, 'Device disconnected');
    if (!connection.isConnected) {
      setState(() {
        _connected = false;
        _isButtonUnavailable = false;
      });
    }
  }

}

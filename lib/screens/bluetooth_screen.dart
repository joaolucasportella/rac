import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simpleblue/model/bluetooth_device.dart';
import 'package:simpleblue/simpleblue.dart';

class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({Key? key}) : super(key: key);

  @override
  State<BluetoothScreen> createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  final _simplebluePlugin = Simpleblue();
  static const _serviceUUID = null;
  static const _scanTimeout = 15000;
  static late bool _listen = true;

  var devices = <String, BluetoothDevice>{};

  String receivedData = '';

  @override
  void initState() {
    super.initState();

    if (_listen) {
      _listen = false;
      _simplebluePlugin.listenConnectedDevice().listen((connectedDevice) {
        debugPrint("Connected device: $connectedDevice");

        if (connectedDevice != null) {
          setState(() {
            devices[connectedDevice.uuid] = connectedDevice;
          });
        }

        connectedDevice?.stream?.listen((received) {
          setState(() {
            receivedData += "${DateTime.now().toString()}: $received\n";
          });
        });
      }).onError((err) {
        debugPrint(err);
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scan();
    });

    _simplebluePlugin.getDevices().then((value) => setState(() {
          for (var device in value) {
            devices[device.uuid] = device;
          }
        }));
  }

  void scan() async {
    final isBluetoothGranted = Platform.isIOS ||
        (await Permission.bluetooth.status) == PermissionStatus.granted ||
        (await Permission.bluetooth.request()) == PermissionStatus.granted;

    if (isBluetoothGranted) {
      debugPrint("Bluetooth permission granted");

      final isLocationGranted = Platform.isIOS ||
          (await Permission.location.status) == PermissionStatus.granted ||
          (await Permission.location.request()) == PermissionStatus.granted;

      if (isLocationGranted) {
        debugPrint("Location permission granted");
        _simplebluePlugin
            .scanDevices(serviceUUID: _serviceUUID, timeout: _scanTimeout)
            .listen((event) {
          setState(() {
            for (var device in event) {
              devices[device.uuid] = device;
            }
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(children: [
          TextButton(
              child: const Text('Get Devices'),
              onPressed: () {
                _simplebluePlugin.getDevices().then((value) {
                  setState(() {
                    for (var device in value) {
                      devices[device.uuid] = device;
                    }
                  });
                });
              }),
          TextButton(
              child: const Text('Scan Devices'),
              onPressed: () {
                scan();
              }),
          Expanded(
            child: buildDevices(),
          ),
          SizedBox(
              height: 200,
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    receivedData,
                    style: const TextStyle(fontSize: 10),
                  )))
        ]),
      ),
    );
  }

  final _connectingUUIDs = <String>[];

  Widget buildDevices() {
    final devList = devices.values.toList();
    return ListView.builder(
        itemCount: devList.length,
        itemBuilder: (context, index) {
          final device = devList[index];

          return ListTile(
            onTap: () {
              if (device.isConnected) {
                _simplebluePlugin.disconnect(device.uuid);
              } else {
                setState(() {
                  _connectingUUIDs.add(device.uuid);
                });
                _simplebluePlugin.connect(device.uuid).then((value) {
                  setState(() {
                    _connectingUUIDs.remove(device.uuid);
                  });
                });
              }
            },
            leading: _connectingUUIDs.contains(device.uuid)
                ? const Icon(Icons.bluetooth, color: Colors.orange)
                : (device.isConnected
                    ? const Icon(Icons.bluetooth_connected, color: Colors.blue)
                    : Icon(
                        Icons.bluetooth,
                        color: Colors.grey.shade300,
                      )),
            title: Text('${device.name ?? 'No name'}\n${device.uuid}'),
            subtitle: device.isConnected
                ? Row(
                    children: [
                      TextButton(
                          child: const Text('Write 1'),
                          onPressed: () {
                            _simplebluePlugin.write(
                                device.uuid, "sample data".codeUnits);
                          }),
                      TextButton(
                          child: const Text('Write 2'),
                          onPressed: () {
                            _simplebluePlugin.write(
                                device.uuid, "sample data 2".codeUnits);
                          })
                    ],
                  )
                : null,
          );
        });
  }
}

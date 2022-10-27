import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simpleblue/model/bluetooth_device.dart';
import 'package:simpleblue/simpleblue.dart';

class BluetoothDevices extends StatefulWidget {
  const BluetoothDevices({Key? key}) : super(key: key);

  @override
  State<BluetoothDevices> createState() => _BluetoothDevicesState();
}

const serviceUUID = null;
const scanTimeout = 15000;

class _BluetoothDevicesState extends State<BluetoothDevices> {
  final _simplebluePlugin = Simpleblue();

  var devices = <String, BluetoothDevice>{};

  String receivedData = '';

  @override
  void initState() {
    super.initState();

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
            .scanDevices(serviceUUID: serviceUUID, timeout: scanTimeout)
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
          title: const Text('Bluetooth'),
        ),
        body: Column(children: [
          TextButton(
              child: const Text('Mostrar dispositivos pareados'),
              onPressed: () {
                _simplebluePlugin.getDevices().then((value) {
                  setState(() {
                    for (var device in value) {
                      devices[device.uuid] = device;
                    }
                  });
                });
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

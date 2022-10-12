import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rac/services/bluetooth.dart';

class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({Key? key}) : super(key: key);

  @override
  State<BluetoothScreen> createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  final _connectingUUIDs = <String>[];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scan();
    });

    Bluetooth.plugin.getDevices().then((value) => setState(() {
          for (var device in value) {
            Bluetooth.devices[device.uuid] = device;
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
        Bluetooth.plugin
            .scanDevices(
                serviceUUID: Bluetooth.serviceUUID,
                timeout: Bluetooth.scanTimeout)
            .listen((event) {
          setState(() {
            for (var device in event) {
              Bluetooth.devices[device.uuid] = device;
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
                Bluetooth.plugin.getDevices().then((value) {
                  setState(() {
                    for (var device in value) {
                      Bluetooth.devices[device.uuid] = device;
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
          )
        ]),
      ),
    );
  }

  Widget buildDevices() {
    final devList = Bluetooth.devices.values.toList();
    return ListView.builder(
        itemCount: devList.length,
        itemBuilder: (context, index) {
          final device = devList[index];

          return ListTile(
            onTap: () {
              if (device.isConnected) {
                Bluetooth.plugin.disconnect(device.uuid);
              } else {
                setState(() {
                  _connectingUUIDs.add(device.uuid);
                });
                Bluetooth.plugin.connect(device.uuid).then((value) {
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
                            Bluetooth.plugin
                                .write(device.uuid, "sample data".codeUnits);
                          }),
                      TextButton(
                          child: const Text('Write 2'),
                          onPressed: () {
                            Bluetooth.plugin
                                .write(device.uuid, "sample data 2".codeUnits);
                          })
                    ],
                  )
                : null,
          );
        });
  }
}

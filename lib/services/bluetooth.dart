import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class Bluetooth {
  late BluetoothConnection _connection;

  Future connect(String address) async {
    try {
      _connection = await BluetoothConnection.toAddress(address);
      debugPrint('Connected to the device');
    } catch (exception) {
      debugPrint('Cannot connect, exception occured');
    }
  }

  Future sendData(Uint8List data) async {
    try {
      _connection.output.add(data);
    } catch (exception) {
      debugPrint('Cannot send data, try again!');
    }
  }
}

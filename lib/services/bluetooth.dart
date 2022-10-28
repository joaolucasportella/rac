import 'package:simpleblue/model/bluetooth_device.dart';
import 'package:simpleblue/simpleblue.dart';

class Bluetooth {
  static final plugin = Simpleblue();
  static var devices = <String, BluetoothDevice>{};
  static const serviceUUID = null;
  static const scanTimeout = 15000;
  static bool listen = true;
}

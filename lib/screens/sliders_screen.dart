import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rac/services/bluetooth.dart';
import 'package:rac/services/database.dart';
import 'package:rac/utilities/navigation_drawer.dart';
import 'package:rac/utilities/constants.dart';
import 'package:simpleblue/model/bluetooth_device.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SlidersScreen extends StatefulWidget {
  const SlidersScreen({Key? key}) : super(key: key);

  @override
  SlidersScreenState createState() => SlidersScreenState();
}

class SlidersScreenState extends State<SlidersScreen> {
  final _database = Database();
  final _padding = const EdgeInsets.symmetric(horizontal: 60);
  final _paddingBottom = const EdgeInsets.fromLTRB(0, 0, 0, 22);
  BluetoothDevice? _connectedDevice;

  double _value1 = 90;
  double _value2 = 90;
  double _value3 = 90;
  double _value4 = 90;
  double _value5 = 90;
  double _value6 = 90;

  List<double> servoData = [90, 90, 90, 90, 90, 90];

  int _times = 0;

  SlidersScreenState() {
    _database.countPresets().then((value) => setState(() {
          _times = value;
        }));

    Bluetooth.plugin.listenConnectedDevice().listen((connectedDevice) {
      debugPrint("Connected device: $connectedDevice");
      _connectedDevice = connectedDevice;
    }).onError((err) {
      debugPrint(err);
    });
  }

  Widget sliders() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(padding: _padding),
        const Text(
          "Motor 1",
          style: labelStyleDark,
        ),
        SfSlider(
          activeColor: const Color(0xFF5969c9),
          value: _value1,
          interval: 36,
          showTicks: true,
          enableTooltip: true,
          onChanged: (newRating) {
            setState(() => _value1 = newRating);
            servoData[0] = _value1;
            if (_connectedDevice != null) {
              var servoDataStringfy =
                  servoData.map((e) => e.toString()).toList().join("");
              Bluetooth.plugin
                  .write(_connectedDevice!.uuid, servoDataStringfy.codeUnits);
            }
          },
          max: 180,
        ),
        Padding(padding: _paddingBottom),
        const Text(
          'Motor 2',
          style: labelStyleDark,
        ),
        SfSlider(
          activeColor: const Color(0xFF5969c9),
          value: _value2,
          interval: 36,
          showTicks: true,
          enableTooltip: true,
          onChanged: (newRating) {
            setState(() => _value2 = newRating);
            servoData[1] = _value1;
            if (_connectedDevice != null) {
              var servoDataStringfy =
                  servoData.map((e) => e.toString()).toList().join("");
              Bluetooth.plugin
                  .write(_connectedDevice!.uuid, servoDataStringfy.codeUnits);
            }
          },
          max: 180,
        ),
        Padding(padding: _paddingBottom),
        const Text(
          'Motor 3',
          style: labelStyleDark,
        ),
        SfSlider(
          activeColor: const Color(0xFF5969c9),
          value: _value3,
          interval: 36,
          showTicks: true,
          enableTooltip: true,
          onChanged: (newRating) {
            setState(() => _value3 = newRating);
            servoData[2] = _value1;
            if (_connectedDevice != null) {
              var servoDataStringfy =
                  servoData.map((e) => e.toString()).toList().join("");
              Bluetooth.plugin
                  .write(_connectedDevice!.uuid, servoDataStringfy.codeUnits);
            }
          },
          max: 180,
        ),
        Padding(padding: _paddingBottom),
        const Text(
          'Motor 4',
          style: labelStyleDark,
        ),
        SfSlider(
          activeColor: const Color(0xFF5969c9),
          value: _value4,
          interval: 36,
          showTicks: true,
          enableTooltip: true,
          onChanged: (newRating) {
            setState(() => _value4 = newRating);
            servoData[3] = _value1;
            if (_connectedDevice != null) {
              var servoDataStringfy =
                  servoData.map((e) => e.toString()).toList().join("");
              Bluetooth.plugin
                  .write(_connectedDevice!.uuid, servoDataStringfy.codeUnits);
            }
          },
          max: 180,
        ),
        Padding(padding: _paddingBottom),
        const Text(
          'Motor 5',
          style: labelStyleDark,
        ),
        SfSlider(
          activeColor: const Color(0xFF5969c9),
          value: _value5,
          interval: 36,
          showTicks: true,
          enableTooltip: true,
          onChanged: (newRating) {
            setState(() => _value5 = newRating);
            servoData[4] = _value1;
            if (_connectedDevice != null) {
              var servoDataStringfy =
                  servoData.map((e) => e.toString()).toList().join("");
              Bluetooth.plugin
                  .write(_connectedDevice!.uuid, servoDataStringfy.codeUnits);
            }
          },
          max: 180,
        ),
        Padding(padding: _paddingBottom),
        const Text(
          'Motor 6',
          style: labelStyleDark,
        ),
        SfSlider(
          activeColor: const Color(0xFF5969c9),
          value: _value6,
          interval: 36,
          showTicks: true,
          enableTooltip: true,
          onChanged: (newRating) {
            setState(() => _value6 = newRating);
            servoData[5] = _value1;
            if (_connectedDevice != null) {
              var servoDataStringfy =
                  servoData.map((e) => e.toString()).toList().join("");
              Bluetooth.plugin
                  .write(_connectedDevice!.uuid, servoDataStringfy.codeUnits);
            }
          },
          max: 180,
        ),
        Padding(padding: _paddingBottom),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        endDrawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: const Text("RAC"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                  Color(0xFF3040a3),
                  Color(0xFF5969c9),
                ])),
          ),
        ),
        backgroundColor: Colors.white,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Stack(
            children: <Widget>[
              SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(
                    20,
                    50,
                    20,
                    10,
                  ),
                  child: Column(
                    children: <Widget>[
                      sliders(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: const Color(0xFF3040a3),
          icon: const Icon(Icons.save),
          label: const Text("Save"),
          onPressed: () {
            _database.setPresets(_times, servoData);
            _times++;
            debugPrint(servoData.toString());
          },
        ),
      ),
    );
  }
}

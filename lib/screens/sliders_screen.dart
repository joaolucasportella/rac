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

  List<String> servoData = ["","","","","",""];

  int _times = 0;

  SlidersScreenState() {
    _database.countPresets().then((value) => setState(() {
          {debugPrint(value.toString());
          _times = value;}
        }));

    // if(Bluetooth.qnt == 1){
      Bluetooth.plugin.listenConnectedDevice().listen((connectedDevice) {
        debugPrint("Connected device: $connectedDevice");
        _connectedDevice = connectedDevice;
      }).onError((err) {
        debugPrint(err);
      });
      // Bluetooth.qnt++;
  // }
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
          interval: 90,
          stepSize: 180,
          showTicks: true,
          enableTooltip: true,
          onChanged: (newRating) {
            setState(() => _value1 = newRating);

            String valueS1 = "";
            if (_connectedDevice != null) {
              //String value = "s1"+_value1.toInt().toString()+"\n";
              if(_value1 >= 90){
                valueS1 = "A";
              }
              else if(_value1 < 80){
                valueS1 = "B";
              }
              servoData[0] = valueS1;  
              Bluetooth.plugin
                  .write(_connectedDevice!.uuid, valueS1.codeUnits);

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
          stepSize: 36,
          showTicks: true,
          enableTooltip: true,
          onChanged: (newRating) {
            setState(() => _value2 = newRating);
            
            String valueS2 = "";
            if (_connectedDevice != null) {
              if(_value2 == 0){
                valueS2 = "C";
              }
              else if(_value2 == 36){
                valueS2 = "D";
              }
              else if(_value2 == 72){
                valueS2 = "E";
              }
              else if(_value2 == 108){
                valueS2 = "F";
              }
              else if(_value2 == 144){
                valueS2 = "G";
              }
              else if(_value2 == 180){
                valueS2 = "H";
              }
              Bluetooth.plugin
                  .write(_connectedDevice!.uuid, valueS2.codeUnits);
              servoData[1] = valueS2;  
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
          stepSize: 36,
          showTicks: true,
          enableTooltip: true,
          onChanged: (newRating) {
            setState(() => _value3 = newRating);
            String valueS3 = "";

            if (_connectedDevice != null) {
              if(_value3 == 0){
                valueS3 = "I";
              }
              else if(_value3 == 36){
                valueS3 = "J";
              }
              else if(_value3 == 72){
                valueS3 = "K";
              }
              else if(_value3 == 108){
                valueS3 = "L";
              }
              else if(_value3 == 144){
                valueS3 = "M";
              }
              else if(_value3 == 180){
                valueS3 = "N";
              }
              Bluetooth.plugin
                  .write(_connectedDevice!.uuid, valueS3.codeUnits);
            }
            servoData[2] = valueS3;  
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
          stepSize: 36,
          showTicks: true,
          enableTooltip: true,
          onChanged: (newRating) {
            setState(() => _value4 = newRating);

            String valueS4 = "";
            if (_connectedDevice != null) {
              if(_value4 == 0){
                valueS4 = "O";
              }
              else if(_value4 == 36){
                valueS4 = "P";
              }
              else if(_value4 == 72){
                valueS4 = "Q";
              }
              else if(_value4 == 108){
                valueS4 = "R";
              }
              else if(_value4 == 144){
                valueS4 = "S";
              }
              else if(_value4 == 180){
                valueS4 = "T";
              }
              Bluetooth.plugin
                  .write(_connectedDevice!.uuid, valueS4.codeUnits);
              servoData[3] = valueS4;  
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
          stepSize: 36,
          showTicks: true,
          enableTooltip: true,
          onChanged: (newRating) {
            setState(() => _value5 = newRating);

            String valueS5 = "";
            if (_connectedDevice != null) {
              if(_value5 == 0){
                valueS5 = "U";
              }
              else if(_value5 == 36){
                valueS5 = "V";
              }
              else if(_value5 == 72){
                valueS5 = "W";
              }
              else if(_value5 == 108){
                valueS5 = "X";
              }
              else if(_value5 == 144){
                valueS5 = "Y";
              }
              else if(_value5 == 180){
                valueS5 = "Z";
              }
              Bluetooth.plugin
                  .write(_connectedDevice!.uuid, valueS5.codeUnits);
              servoData[4] = valueS5;      
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
          stepSize: 36,
          showTicks: true,
          enableTooltip: true,
          onChanged: (newRating) {
            setState(() => _value6 = newRating);
            

            String valueS6 = "";
            if (_connectedDevice != null) {
               if(_value6 == 0){
                valueS6 = "a";
              }
              else if(_value6 == 36){
                valueS6 = "b";
              }
              else if(_value6 == 72){
                valueS6 = "c";
              }
              else if(_value6 == 108){
                valueS6 = "d";
              }
              else if(_value6 == 144){
                valueS6 = "e";
              }
              else if(_value6 == 180){
                valueS6 = "f";
              }
              Bluetooth.plugin
                  .write(_connectedDevice!.uuid, valueS6.codeUnits);
              servoData[5] = valueS6;    
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

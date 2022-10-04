import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rac/services/database.dart';
import 'package:rac/utilities/navigation_drawer.dart';
import 'package:rac/utilities/constants.dart';
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
  double _value1 = 50;
  double _value2 = 50;
  double _value3 = 50;
  double _value4 = 50;
  double _value5 = 50;
  double _value6 = 50;
  int _times = 0;

  SlidersScreenState() {
    _database.countPresets().then((value) => setState(() {
          _times = value;
        }));
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
          interval: 20,
          showTicks: true,
          enableTooltip: true,
          onChanged: (newRating) {
            setState(() => _value1 = newRating);
          },
          max: 100,
        ),
        Padding(padding: _paddingBottom),
        const Text(
          'Motor 2',
          style: labelStyleDark,
        ),
        SfSlider(
          activeColor: const Color(0xFF5969c9),
          value: _value2,
          interval: 20,
          showTicks: true,
          enableTooltip: true,
          onChanged: (newRating) {
            setState(() => _value2 = newRating);
          },
          max: 100,
        ),
        Padding(padding: _paddingBottom),
        const Text(
          'Motor 3',
          style: labelStyleDark,
        ),
        SfSlider(
          activeColor: const Color(0xFF5969c9),
          value: _value3,
          interval: 20,
          showTicks: true,
          enableTooltip: true,
          onChanged: (newRating) {
            setState(() => _value3 = newRating);
          },
          max: 100,
        ),
        Padding(padding: _paddingBottom),
        const Text(
          'Motor 4',
          style: labelStyleDark,
        ),
        SfSlider(
          activeColor: const Color(0xFF5969c9),
          value: _value4,
          interval: 20,
          showTicks: true,
          enableTooltip: true,
          onChanged: (newRating) {
            setState(() => _value4 = newRating);
          },
          max: 100,
        ),
        Padding(padding: _paddingBottom),
        const Text(
          'Motor 5',
          style: labelStyleDark,
        ),
        SfSlider(
          activeColor: const Color(0xFF5969c9),
          value: _value5,
          interval: 20,
          showTicks: true,
          enableTooltip: true,
          onChanged: (newRating) {
            setState(() => _value5 = newRating);
          },
          max: 100,
        ),
        Padding(padding: _paddingBottom),
        const Text(
          'Motor 6',
          style: labelStyleDark,
        ),
        SfSlider(
          activeColor: const Color(0xFF5969c9),
          value: _value6,
          interval: 20,
          showTicks: true,
          enableTooltip: true,
          onChanged: (newRating) {
            setState(() => _value6 = newRating);
          },
          max: 100,
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
            List<double> servoData = [];
            servoData.add(_value1);
            servoData.add(_value2);
            servoData.add(_value3);
            servoData.add(_value4);
            servoData.add(_value5);
            servoData.add(_value6);
            _database.setPresets(_times, servoData);
            _times++;
            debugPrint(servoData.toString());
          },
        ),
      ),
    );
  }
}

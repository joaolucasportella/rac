import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rac/utilities/navigation_drawer.dart';
import 'package:rac/utilities/constants.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SlidersScreen extends StatefulWidget {
  const SlidersScreen({Key? key}) : super(key: key);

  @override
  SlidersScreenState createState() => SlidersScreenState();
}

class SlidersScreenState extends State<SlidersScreen> {
  final padding = const EdgeInsets.symmetric(horizontal: 60);
  final paddingBottom = const EdgeInsets.fromLTRB(0, 0, 0, 22);

  double value1 = 50;
  double value2 = 50;
  double value3 = 50;
  double value4 = 50;
  double value5 = 50;
  double value6 = 50;

  Widget sliders() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(padding: padding),
        const Text(
          "Motor 1",
          style: labelStyleDark,
        ),
        SfSlider(
          activeColor: const Color(0xFF5969c9),
          value: value1,
          interval: 20,
          showTicks: true,
          enableTooltip: true,
          onChanged: (newRating) {
            setState(() => value1 = newRating);
          },
          max: 100,
        ),
        Padding(padding: paddingBottom),
        const Text(
          'Motor 2',
          style: labelStyleDark,
        ),
        SfSlider(
          activeColor: const Color(0xFF5969c9),
          value: value2,
          interval: 20,
          showTicks: true,
          enableTooltip: true,
          onChanged: (newRating) {
            setState(() => value2 = newRating);
          },
          max: 100,
        ),
        Padding(padding: paddingBottom),
        const Text(
          'Motor 3',
          style: labelStyleDark,
        ),
        SfSlider(
          activeColor: const Color(0xFF5969c9),
          value: value3,
          interval: 20,
          showTicks: true,
          enableTooltip: true,
          onChanged: (newRating) {
            setState(() => value3 = newRating);
          },
          max: 100,
        ),
        Padding(padding: paddingBottom),
        const Text(
          'Motor 4',
          style: labelStyleDark,
        ),
        SfSlider(
          activeColor: const Color(0xFF5969c9),
          value: value4,
          interval: 20,
          showTicks: true,
          enableTooltip: true,
          onChanged: (newRating) {
            setState(() => value4 = newRating);
          },
          max: 100,
        ),
        Padding(padding: paddingBottom),
        const Text(
          'Motor 5',
          style: labelStyleDark,
        ),
        SfSlider(
          activeColor: const Color(0xFF5969c9),
          value: value5,
          interval: 20,
          showTicks: true,
          enableTooltip: true,
          onChanged: (newRating) {
            setState(() => value5 = newRating);
          },
          max: 100,
        ),
        Padding(padding: paddingBottom),
        const Text(
          'Motor 6',
          style: labelStyleDark,
        ),
        SfSlider(
          activeColor: const Color(0xFF5969c9),
          value: value6,
          interval: 20,
          showTicks: true,
          enableTooltip: true,
          onChanged: (newRating) {
            setState(() => value6 = newRating);
          },
          max: 100,
        ),
        Padding(padding: paddingBottom),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        endDrawer: const NavigationDrawerWidget(),
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
            servoData.add(value1);
            servoData.add(value2);
            servoData.add(value3);
            servoData.add(value4);
            servoData.add(value5);
            servoData.add(value6);
            debugPrint(servoData.toString());
          },
        ),
      ),
    );
  }
}

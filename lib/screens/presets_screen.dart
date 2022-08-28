import 'package:flutter/material.dart';

class PresetScreen extends StatefulWidget {
  const PresetScreen({Key? key}) : super(key: key);

  @override
  PresetScreenState createState() => PresetScreenState();
}

class PresetScreenState extends State<PresetScreen> {
  final padding = const EdgeInsets.symmetric(horizontal: 60);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Presets"),
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
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  100,
                  20,
                  10,
                ),
                child: Column(children: const <Widget>[]),
              )),
        ));
  }
}

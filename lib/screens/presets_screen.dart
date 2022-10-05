import 'package:flutter/material.dart';
import 'package:rac/services/database.dart';
import 'package:rac/utilities/constants.dart';

class PresetScreen extends StatefulWidget {
  const PresetScreen({Key? key}) : super(key: key);

  @override
  PresetScreenState createState() => PresetScreenState();
}

class PresetScreenState extends State<PresetScreen> {
  final _database = Database();
  int _countOfPresets = 0;
  bool _isVisible = false;
  Color cor = Colors.blue;

  PresetScreenState() {
    _database.countPresets().then((value) => setState(() {
          _countOfPresets = value;
        }));
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
        appBar: AppBar(
          title: Text("PRESETS", style: textStyleTitle),
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
          child: _presetsButtons(),
        ));
  }

  Widget _presetsButtons() {
    return GridView.extent(
        maxCrossAxisExtent: 360,
        padding: const EdgeInsets.all(4),
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        children: _buildGridTileList(_countOfPresets));
  }

  List<Container> _buildGridTileList(int count) => List.generate(
        count,
        (i) => Container(
            width: 181,
            height: 181,
            padding: const EdgeInsets.all(5),
            child: Stack(
              alignment: Alignment.topRight,
              children: <Widget>[
                GestureDetector(
                  onLongPress: () {
                    debugPrint("segurou");
                    setState(() {
                      _isVisible = !_isVisible;
                      if (_isVisible) {
                        cor = Colors.red;
                      } else {
                        cor = Colors.blue;
                      }
                    });
                  },
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _database.getPresets(i);
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: const Color(0xFF5969c9),
                        backgroundColor: Colors.white,
                        minimumSize: const Size(181, 181),
                        side: BorderSide(
                          width: 5,
                          color: cor,
                        )),
                    icon: const Icon(Icons.settings_outlined),
                    label: Text("Preset | ${i + 1}", style: textStyleBlue),
                  ),
                ),
                Visibility(
                  visible: _isVisible,
                  child: IconButton(
                      onPressed: () {
                        //_database.deletePreset(i);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PresetScreen()));
                      },
                      icon: const Icon(Icons.delete),
                      color: cor),
                )
              ],
            )),
      );
}

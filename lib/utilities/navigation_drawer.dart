import 'package:flutter/material.dart';
import 'package:rac/main.dart';
import 'package:rac/screens/bluetooth_screen.dart';
import 'package:rac/screens/presets_screen.dart';
import 'package:rac/services/authentication.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class NavigationDrawerWidget extends StatelessWidget {
  NavigationDrawerWidget({Key? key}) : super(key: key);

  final _auth = Authentication();
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    String _email = _auth.getCurrentUserEmail();
    String _imagem = _auth.getCurrentUserIcons();
    return Drawer(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Color(0xFF5969c9),
              Color(0xFF3040a3),
            ])),
        child: ListView(
          children: <Widget>[
            Padding(padding: padding),
            buildHeader(_imagem, _email),
            btn(context),
            const Divider(
              color: Color(0xFFffffff),
            ),
            buildMenuItem(
                'Bluetooth', Icons.bluetooth, () => selectedItem(context, 1)),
            buildMenuItem(
                'Presets', Icons.handyman, () => selectedItem(context, 2)),
            //),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(String imagem, String email) {
    return InkWell(
      child: Container(
        padding: padding.add(const EdgeInsets.symmetric(vertical: 20)),
        child: Column(
          children: <Widget>[
            Padding(
                padding: padding.add(const EdgeInsets.fromLTRB(0, 20, 0, 0))),
            CircleAvatar(radius: 45, backgroundImage: NetworkImage(imagem)),
            const SizedBox(width: 10),
            Padding(
                padding: padding.add(const EdgeInsets.fromLTRB(0, 15, 0, 0))),
            Text(email,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                  fontSize: 16,
                ))
          ],
        ),
      ),
    );
  }

  Widget btn(BuildContext context) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SocialLoginButton(
          height: 30,
          width: 150,
          borderRadius: 20,
          backgroundColor: Colors.white,
          text: "Sign out",
          textColor: const Color(0xFF3040a3),
          buttonType: SocialLoginButtonType.generalLogin,
          onPressed: () {
            _auth.signOut();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MainPage()),
            );
          },
        ),
        Padding(padding: padding.add(const EdgeInsets.fromLTRB(0, 0, 0, 13))),
      ],
    );
  }

  Widget buildMenuItem(String text, IconData icon, VoidCallback? onCicked) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(text),
      hoverColor: Colors.white70,
      onTap: onCicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 1:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const BluetoothScreen()));
        break;
      case 2:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const PresetScreen()));
        break;
    }
  }
}

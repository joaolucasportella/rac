import 'package:flutter/material.dart';
import 'package:rac/main.dart';
import 'package:rac/screens/presets_screen.dart';
import 'package:rac/screens/devices_screen.dart';
import 'package:rac/services/normal_authentication.dart';
import 'package:rac/utilities/constants.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  const NavigationDrawerWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const String name = 'Nome do Usuário';
    const String email = 'email@usuario.com';
    const String imagem =
        'https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-portrait-176256935.jpg';
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
            //Material(
            Padding(padding: padding),
            buildHeader(imagem, name, email),
            btn(context),
            const Divider(
              color: Color(0xFFffffff),
            ),
            buildMenuItem('Configurações', Icons.settings,
                () => selectedItem(context, 0)),
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

  Widget buildHeader(String imagem, String name, String email) {
    return InkWell(
      child: Container(
        padding: padding.add(const EdgeInsets.symmetric(vertical: 50)),
        child: Row(
          children: [
            CircleAvatar(radius: 45, backgroundImage: NetworkImage(imagem)),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: kLabelStyleHeader,
                ),
                Text(
                  email,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                      fontSize: 11.5),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget btn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
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
            Authentication().signOut();
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
            MaterialPageRoute(builder: (context) => const ScanDevicesScreen()));
        break;
      case 2:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const PresetScreen()));
        break;
    }
  }
}

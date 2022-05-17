import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rac/screens/home_screen.dart';
import 'package:rac/screens/login_screen.dart';
import 'package:rac/services/google_auth.dart';

void main() async {
  // Inicializa o Firebase e o Aplicativo
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.fromSwatch()
                  .copyWith(secondary: Colors.indigoAccent)),
          home: const MainPage(),
        ),
      );
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("Algo deu errado!"));
            } else if (snapshot.hasData) {
              // Verifica se o usuário já fez o login antes
              return const HomeScreen();
            } else {
              return const LoginScreen();
            }
          },
        ),
      );
}

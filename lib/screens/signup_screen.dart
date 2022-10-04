import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rac/main.dart';
import 'package:rac/services/authentication.dart';
import 'package:rac/utilities/constants.dart';
import 'package:rac/utilities/messages.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = Authentication();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();

  Widget _buildEmailTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: labelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          margin: const EdgeInsets.only(bottom: 30.0),
          alignment: Alignment.centerLeft,
          decoration: boxDecorationStyle,
          height: 60,
          child: TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: textStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Digite seu Email',
              hintStyle: textStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Senha',
          style: labelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          margin: const EdgeInsets.only(bottom: 30.0),
          alignment: Alignment.centerLeft,
          decoration: boxDecorationStyle,
          height: 60,
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            style: textStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Digite sua senha',
              hintStyle: textStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTextField2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Confirmar Senha',
          style: labelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: boxDecorationStyle,
          height: 60,
          child: TextField(
            controller: _password2Controller,
            obscureText: true,
            style: textStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Digite sua senha',
              hintStyle: textStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Column(
        children: <Widget>[
          SocialLoginButton(
            borderRadius: 30,
            backgroundColor: Colors.white,
            text: "CADASTRAR",
            textColor: const Color(0xFF3040a3),
            buttonType: SocialLoginButtonType.generalLogin,
            onPressed: () {
              if (_passwordController.text == _password2Controller.text &&
                  _passwordController.text.trim().length >= 6) {
                _auth.signUp(context, _emailController.text.trim(),
                    _passwordController.text.trim());
              } else {
                messageToUser(
                    context, "Email ou Senha inválidos! Tente novamente!", 2);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MainPage()),
        );
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(text: 'Já possui uma conta? ', style: textStyle),
            TextSpan(text: 'Entrar', style: labelStyle),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFF5969c9),
                        Color(0xFF3040a3),
                      ]),
                ),
              ),
              SizedBox(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Image(
                        image: AssetImage('assets/logos/logo.png'),
                        width: 120,
                        height: 120,
                      ),
                      const SizedBox(height: 10.0),
                      Text('CADASTRAR', style: textStyleTitle),
                      const SizedBox(height: 25.0),
                      _buildEmailTextField(),
                      _buildPasswordTextField(),
                      _buildPasswordTextField2(),
                      const SizedBox(height: 20.0),
                      _buildSignUpButton(),
                      _buildLoginButton(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rac/screens/forgot_password_screen.dart';
import 'package:rac/screens/signup_screen.dart';
import 'package:rac/services/authentication.dart';
import 'package:rac/utilities/constants.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
              hintText: 'Entre com o seu Email',
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
          alignment: Alignment.centerLeft,
          decoration: boxDecorationStyle,
          height: 60.0,
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
              hintText: 'Entre com a sua Senha',
              hintStyle: textStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordButton() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ForgotPasswordScreen()),
          );
        },
        child: Text(
          'Esqueceu a sua senha?',
          style: labelStyle,
        ),
      ),
    );
  }

  Widget _buildLogInButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Column(
        children: <Widget>[
          SocialLoginButton(
              borderRadius: 30,
              backgroundColor: Colors.white,
              text: "LOGIN",
              textColor: const Color(0xFF3040a3),
              buttonType: SocialLoginButtonType.generalLogin,
              onPressed: () {
                Authentication().signIn(context, _emailController.text.trim(),
                    _passwordController.text.trim());
              }),
        ],
      ),
    );
  }

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          'OU',
          style: textStyle,
        ),
        const SizedBox(height: 20.0),
        Text(
          'ENTRE COM',
          style: textStyle,
        ),
      ],
    );
  }

  Widget _buildGoogleLogInButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Column(
        children: <Widget>[
          SocialLoginButton(
            borderRadius: 30,
            text: "GOOGLE",
            textColor: const Color(0xFF3040a3),
            buttonType: SocialLoginButtonType.google,
            onPressed: () {
              Authentication().googleLogIn(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignUpScreen()),
        );
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(text: 'Não possui uma conta? ', style: textStyle),
            TextSpan(text: 'Cadastre-se', style: labelStyle),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      Text('ENTRAR', style: textStyleTitle),
                      const SizedBox(height: 25.0),
                      _buildEmailTextField(),
                      _buildPasswordTextField(),
                      _buildForgotPasswordButton(),
                      _buildLogInButton(),
                      _buildSignInWithText(),
                      _buildGoogleLogInButton(),
                      _buildSignUpButton(),
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

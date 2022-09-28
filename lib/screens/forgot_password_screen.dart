import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rac/main.dart';
import 'package:rac/services/reset_password.dart';
import 'package:rac/utilities/constants.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

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

  Widget _buildForgotPasswordButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Column(
        children: <Widget>[
          SocialLoginButton(
            borderRadius: 30,
            backgroundColor: Colors.white,
            text: "ENVIAR EMAIL",
            textColor: const Color(0xFF3040a3),
            buttonType: SocialLoginButtonType.generalLogin,
            onPressed: () {
              ResetPassword().sendEmail(context, _emailController.text.trim());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGoBackButton() {
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
            TextSpan(text: 'Lembrou sua senha? ', style: textStyle),
            TextSpan(text: 'Voltar', style: labelStyle),
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
                height: double.infinity,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Image(
                        image: AssetImage(
                          'assets/logos/logo.png',
                        ),
                        width: 120,
                        height: 120,
                      ),
                      const SizedBox(height: 10.0),
                      Text('RECUPERAR SENHA', style: labelStyleTitle),
                      const SizedBox(height: 25.0),
                      _buildEmailTextField(),
                      const SizedBox(height: 20.0),
                      _buildForgotPasswordButton(),
                      _buildGoBackButton(),
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

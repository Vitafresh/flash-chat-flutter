import 'package:flutter/material.dart';
import 'package:flash_chat/components/button_rounded.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  String email;
  String password;

  bool _showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 150.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextField(
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your e-mail'),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password'),
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                ),
                SizedBox(
                  height: 24.0,
                ),
                buttonRounded(
                    onTap: () async {
                      setState(() {
                        _showSpinner = true;
                      });
                      try {
                        print('********* Trying to Log In User  ************');
                        print('email = $email');
                        print('password=$password');

                        final user = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        print('********* User Loged In ************');
                        if (user != null) {
                          print(user);
                          Navigator.pushNamed(context, ChatScreen.id);
                        }
                      } catch (e) {
                        print('Exception signInWithEmailAndPassword:');
                        print(e);
                      }
                      setState(() {
                        _showSpinner = false;
                      });
                    },
                    color: Colors.lightBlueAccent,
                    caption: 'Log In'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

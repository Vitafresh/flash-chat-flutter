import 'package:flash_chat/components/button_rounded.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _auth = FirebaseAuth.instance;

  String email;
  String password;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 18.0,
              ),
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
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your e-mail'),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value){
                  email=value;
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your password'),
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value){
                  password=value;
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              buttonRounded(
                  onTap: () async {
                    //Implement registration functionality.
                    try {
                      final newUser = await _auth
                          .createUserWithEmailAndPassword(
                          email: email, password: password);
                      if(newUser != null){
                        Navigator.pushNamed(context, ChatScreen.id);
                      }
                    }
                    catch (e){
                      print('Exception:');
                      print(e);
                    }
                    print('email = $email');
                    print('password = $password');
                  },
                  color: Colors.blueAccent,
                  caption: 'Register')
            ],
          ),
        ),
      ),
    );
  }
}

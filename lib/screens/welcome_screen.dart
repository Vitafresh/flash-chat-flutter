import 'package:flutter/material.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/components/button_rounded.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Initialize Firebase Core
    // https://firebase.flutter.dev/docs/overview/#initializing-flutterfire
    initializeFlutterFire();

    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    // animation = CurvedAnimation(parent: controller,curve: Curves.easeIn);
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    controller.forward();
    //controller.reverse(from: 1.0);

    // animation.addStatusListener((status) {
    //   print(status);
    //   if(status==AnimationStatus.completed){
    //     controller.reverse(from: 1.0);
    //   }
    //   else if(status==AnimationStatus.dismissed){
    //     controller.forward();
    //   }
    //
    // });

    controller.addListener(() {
      setState(() {
        // Если не сделать, то анимация не будет обновляться в интерфейсе
        // Достаточно пустого setState
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    //height: 60.0,
                    height: 60,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text: ['Flash Chat'],
                  speed: Duration(milliseconds: 200),
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            buttonRounded(
              onTap: () async {
                //Go to login screen.
                if (_initialized) {
                  // Firebase Core was initialized
                  Navigator.pushNamed(context, LoginScreen.id);
                }
              },
              color: Colors.lightBlueAccent,
              caption: 'Log In',
            ),
            buttonRounded(
                onTap: () async {
                  if (_initialized) {
                    // Firebase Core was initialized
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  }
                },
                color: Colors.blueAccent,
                caption: "Register"),
          ],
        ),
      ),
    );
  }
}

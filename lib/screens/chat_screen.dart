import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  User firebaseUser; //messageSender = firebaseUser.email
  String messageText;

  @override
  void initState() {
    super.initState();
    firebaseUser = getCurrentUser();
  }

  User getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {

        print('Firebase user email:');
        print(user.email);
        return user;
      }
    } catch (e) {
      print('Exception getCurrentUser:');
      print(e);
      return null;
    }
    return null;
  }

  void getMessages() async {
    print('*************************  getMessages  **********************');
    final messages = await _firestore.collection('messages').get();
    print('*************************  var message in messages.docs  **********************');
    for (var message in messages.docs) {
      print(message.data());
    }
  }

  void getMessagesStream() async {
    await for(var snap in _firestore.collection('messages').snapshots()){
      for(var message in snap.docs){
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality

                print('************  getMessages();  ***************');
                //getMessages();
                getMessagesStream();
                print('************  getMessages() END  ***************');

                // _auth.signOut();
                // Navigator.pop(context);

              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('messages').snapshots(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    final messages = snapshot.data.docs;
                    List<Text> messageWidgets = [];
                    print('MessageText:');
                    for(QueryDocumentSnapshot msg in messages){
                      final Map<String, dynamic> messageMap = msg.data();
                      final String messageText=messageMap['text'];
                      final String messageSender=messageMap['sender'];
                      final messageWidget = Text('$messageText from $messageSender');
                      messageWidgets.add(messageWidget);
                    }
                    return Column(
                      children: messageWidgets,
                    );
                  }
                  return null;
                },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      //Implement send functionality.
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': firebaseUser.email,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

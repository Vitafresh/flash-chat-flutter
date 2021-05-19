import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class TextboxRouded extends StatelessWidget {
  TextboxRouded({@required this.onChanged, @required this.hintText});
  final Function onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      //style: TextStyle(color: Colors.black),
      //
      // Decoration is stored completely in constatnts.dart
      // changing only a hintText property by .copyWith() replacing by our own value
      decoration: kTextFieldDecoration.copyWith(hintText: hintText),
    );
  }
}
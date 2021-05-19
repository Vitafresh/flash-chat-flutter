import 'package:flutter/material.dart';

class buttonRounded extends StatelessWidget {
  buttonRounded({@required this.onTap, @required this.color, @required this.caption});
  final Function onTap;
  final Color color;
  final String caption;

  // const buttonLoginRegister({
  //   Key key,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        //color: Colors.lightBlueAccent,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed:onTap,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            caption,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

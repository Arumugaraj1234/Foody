import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final String title;
  final Widget icon;
  final Function onTapped;

  RoundedButton({this.color, this.title, this.icon, this.onTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      child: FlatButton(
        onPressed: onTapped,
        child: Padding(
          padding: EdgeInsets.only(left: 0.0, right: 50.0),
          child: ListTile(
            title: Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 21.0,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            leading: icon,
          ),
        ),
      ),
    );
  }
}

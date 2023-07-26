import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget currentweather(IconData icon, String iconname, String icondata) {
  return Container(
    padding: EdgeInsets.all(10),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 30,
        ),
        SizedBox(height: 5),
        Text(
          iconname,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          icondata,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}

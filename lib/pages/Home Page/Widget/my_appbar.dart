import 'package:flutter/material.dart';

AppBar myAppBar(String firstText, String secondText) {
  
  return AppBar(
    backgroundColor: Colors.grey.shade100,
    centerTitle: true,
    title: RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(text: firstText),
          TextSpan(text: secondText, style: TextStyle(color: Colors.orange)),
        ],
      ),
    ),
  );
}

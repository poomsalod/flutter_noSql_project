import 'package:flutter/material.dart';
import 'package:flutter_final/Screen/welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note app',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: WelcomeScreen(),
    );
  }
}

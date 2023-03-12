import 'package:flutter/material.dart';
import 'package:ppostman/dimantions/dimation.dart';
import 'package:ppostman/pages/flash_screen.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Dimantions.setSize = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PPOST MAN',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const FleshScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ppostman/get_helper/init.dart';
import 'package:ppostman/pages/home_page.dart';

class FleshScreen extends StatelessWidget {
  const FleshScreen({super.key});

  @override
  Widget build(BuildContext context) {
    init().then(
        (value) => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const HomePage(),
            )));
    return const Scaffold(
      body: Center(child: SingleChildScrollView()),
    );
  }
}

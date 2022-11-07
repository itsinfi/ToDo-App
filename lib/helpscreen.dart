import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Starter-Guide'),
        backgroundColor: Color.fromRGBO(70, 70, 70, 1),
      ),
      body: Container(
        child: Text(''),
      ),
      backgroundColor: Colors.black,
    );
  }
}

import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final name = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Canage Begins $name'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        titleTextStyle: TextStyle(fontSize: 25, color: Colors.white),
      ),
      body: TextButton(
        onPressed: () {
          Navigator.of(context).pop('This is from the Second Screen');
        },
        child: Text('Return to HomePage'),
      ),
    );
    
  }
}

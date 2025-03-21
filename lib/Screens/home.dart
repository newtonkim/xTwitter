import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [TextButton(onPressed: (){
          FirebaseAuth.instance.signOut();
        }, child: Text(
            "Sign Out",
            style: TextStyle(
              color: const Color.fromARGB(255, 66, 127, 241)
              ),
          ))],
      ),
      body: const Center(
        child: Text('Home Page'),
      ),
    );
  }
}
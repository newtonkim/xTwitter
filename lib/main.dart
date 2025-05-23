

import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:demo/Screens/home.dart';
import 'package:demo/Screens/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:demo/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override

  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue, 
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent, 
          shadowColor: Colors.transparent,
          // backgroundColor: Colors.blue, 
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16
            ) ,
          centerTitle: true, 
        ),
       
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ref.read(userProvider.notifier).login(snapshot.data!.email!);
            return const Home();
          }
          return SignIn();
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:demo/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [TextButton(onPressed: (){
          FirebaseAuth.instance.signOut();
          ref.read(userProvider.notifier).logout();
        }, child: Text(
            "Sign Out",
            style: TextStyle(
              color: const Color.fromARGB(255, 66, 127, 241)
              ),
          ))],
      ),
      body: Column(
        children: [
         Text(ref.watch(userProvider).user.email),
         Text(ref.watch(userProvider).user.name),
         CircleAvatar(
          backgroundImage: NetworkImage(
            ref.watch(userProvider).user.profilePic),
          )
        ],
      ),
    );
  }
}
import 'package:demo/Screens/create_tweet.dart';
import 'package:flutter/material.dart';
import 'package:demo/Screens/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:demo/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LocalUser currentUser = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(color: Colors.white)),
        leading:   Builder(
          builder: (context) {
            return GestureDetector(
              onTap: (){
                Scaffold.of(context).openDrawer();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    currentUser.user.profilePic),
                  ),
              ),
            );
          }
        ),
      ),
      body: Column(
        children: [
         Text(currentUser.user.email),
         Text(currentUser.user.name),
        ],
      ),
      drawer: Drawer(
  child: Column(
    children: [
      SizedBox(
        width: double.infinity, 
        height: 300, 
        child: Image.network(
          currentUser.user.profilePic,
          fit: BoxFit.cover, 
        ),
      ),

      ListTile(
        title: Text(
          "Hello, ${currentUser.user.name}",
            style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),

      ListTile(
        title: Text("Settings"),
        onTap: () {
          Navigator.pop(context);
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const 
           Settings(),
          ),
          );
        } ,
      ),

      ListTile(
        title: Text("Sign Out"),
        onTap: () {
          FirebaseAuth.instance.signOut();
          ref.read(userProvider.notifier).logout();
        } ,
      )
        ]
      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const 
           CreateTweet(),
          ),
          );
        }, 
        child: const Icon(
          Icons.add
        ),
      ),
    );
  }
}
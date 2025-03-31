import 'package:flutter/material.dart';

class CreateTweet extends StatelessWidget {
  const CreateTweet({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController tweetController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post a Tweet")),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                  controller: tweetController,
              ),
            )
        ])
    );
  }
}
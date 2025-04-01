import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/models/tweet.dart';
import 'package:demo/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tweetProvider = Provider<TwitterApi>((ref) {
  return TwitterApi(ref);
});

class TwitterApi {
  TwitterApi(this.ref);
  final Ref ref;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> postTweet(String tweet) async {
    LocalUser currentUser = ref.watch(userProvider);

    await _firestore.collection("tweets").add(
      Tweet(
         tweet: tweet,
        uid:currentUser.id,
        name: currentUser.user.name,
        profilePic: currentUser.user.profilePic,
        postTime: Timestamp.now(),
      ).toMap(),
    );

  }
}
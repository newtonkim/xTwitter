// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Tweet {
  final String uid;
  final String name;
  final String tweet;
  final String profilePic;
  final Timestamp postTime;


// Constructor
  const Tweet({
    required this.uid,
    required this.name,
    required this.tweet,
    required this.profilePic,
    required this.postTime,
  });

  Tweet copyWith({
    String? uid,
    String? name,
    String? tweet,
    String? profilePic,
    Timestamp? postTime,
  }) {
    return Tweet(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      tweet: tweet ?? this.tweet,
      profilePic: profilePic ?? this.profilePic,
      postTime: postTime ?? this.postTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'tweet': tweet,
      'profilePic': profilePic,
      'postTime': postTime,
    };
  }

  factory Tweet.fromMap(Map<String, dynamic> map) {
    return Tweet(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      tweet: map['tweet'] ?? '',
      profilePic: map['profilePic'] ?? '',
      postTime: map['postTime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Tweet.fromJson(String source) => Tweet.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Tweet(uid: $uid, name: $name, tweet: $tweet, profilePic: $profilePic, postTime: $postTime)';
  }

  @override
  bool operator ==(covariant Tweet other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.name == name &&
      other.tweet == tweet &&
      other.profilePic == profilePic &&
      other.postTime == postTime;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      name.hashCode ^
      tweet.hashCode ^
      profilePic.hashCode ^
      postTime.hashCode;
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'dart:io';

import 'package:demo/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateNotifierProvider<UserNotifier, LocalUser>((ref) {
  return UserNotifier();
});

class LocalUser {
  const LocalUser({required this.id, required this.user});

  final String id;
  final FirebaseUser user;

  LocalUser copyWith({String? id, FirebaseUser? user}) {
    return LocalUser(id: id ?? this.id, user: user ?? this.user);
  }
}

class UserNotifier extends StateNotifier<LocalUser> {
  UserNotifier()
    : super(
        const LocalUser(
          id: 'error',
          user: FirebaseUser(
            email: 'error',
            name: 'error',
            profilePic: 'error',
          ),
        ),
      );

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  /// Logs in to the app with the given [email].
  ///
  /// This function is called after a user has authenticated with Firebase
  /// Authentication. It looks up the user in the Firestore database and
  /// updates the local state with the user's data.
  ///
  /// If the user is not found in the Firestore database, this function will
  /// do nothing.
  ///
  /// If there is more than one user in the Firestore database with the given
  /// email address, this function will do nothing.
  Future<void> login(String email) async {
    QuerySnapshot response =
        await _firestore
            .collection("users")
            .where("email", isEqualTo: email)
            .get();

    if (response.docs.isEmpty) {
      print(" No firestore user associated to authenticated email $email");
      return;
    }

    if (response.docs.length != 1) {
      print(
        " More than one firestore user associated to authenticated email $email",
      );
      return;
    }

    state = LocalUser(
      id: response.docs[0].id,
      user: FirebaseUser.fromMap(
        response.docs[0].data() as Map<String, dynamic>,
      ),
    );
  }

  //CRUD
  //1.  ********************************** Create  *********************************
  /// Signs up a new user with the given [email].
  /// 
  /// This function creates a new user document in the Firestore database with
  /// the specified [email], a default name "No Name", and a default profile 
  /// picture URL. It then retrieves the created document and updates the local
  /// state with the new user's information.

  Future<void> signUp(String email) async {
    DocumentReference response = await _firestore
        .collection("users")
        .add(
          FirebaseUser(
            email: email,
            name: "No Name",
            profilePic: "https://picsum.photos/200/300?grayscale",
          ).toMap(),
        );
    // ********************************* End of create *********************************

    // 2.  ********************************* Read *********************************
    DocumentSnapshot snapshot = await response.get();

    // ********************************* End of Read *********************************

    state = LocalUser(
      id: response.id,
      user: FirebaseUser.fromMap(snapshot.data() as Map<String, dynamic>),
    );
  }

  //3. ********************************* Update *********************************
  /// Updates the name of the current user in firestore and in the local state.
  Future<void> updateName(String name) async {
    await _firestore.collection("users").doc(state.id).update({"name": name});
    state = state.copyWith(user: state.user.copyWith(name: name));
  }
  // ********************************* End of Update *********************************

  /// Uploads the given [image] to firebase storage and updates the user's
  /// profile picture url in firestore.
  ///
  /// This will also update the user's local state with the new profile picture
  /// url.
  Future<void> updateImage(File image) async {
    Reference ref = _storage.ref().child("users").child(state.id);
    TaskSnapshot snapshot = await ref.putFile(image);
    String profilePicUrl = await snapshot.ref.getDownloadURL();

    await _firestore.collection("users").doc(state.id).update({
      "profilePic": profilePicUrl,
    });
    state = state.copyWith(user: state.user.copyWith(profilePic: profilePicUrl));
  }

  /// Resets the user state to an error state, used to log out.
  void logout() {
    state = const LocalUser(
      id: 'error',
      user: FirebaseUser(email: 'error', name: 'error', profilePic: 'error'),
    );
  }


}

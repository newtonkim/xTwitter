// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:demo/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateNotifierProvider<UserNotifier, LocalUser>((ref) {
  return UserNotifier();
});

class LocalUser {
  const LocalUser({required this.id, required this.user});

  final String id;
  final FirebaseUser user;

  LocalUser copyWith({
    String? id, 
    FirebaseUser? user
    }) {
    return LocalUser(
      id: id ?? this.id,
      user: user ?? this.user
      );
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

  Future<void> login(String email) async {
    QuerySnapshot response =
        await _firestore
            .collection("users")
            .where("email", isEqualTo: email)
            .get();

            if(response.docs.isEmpty){ 
                print(" No firestore user associated to authenticated email $email");
                return ;
            }

            if(response.docs.length != 1){
              print(" More than one firestore user associated to authenticated email $email");
              return ;
            }

    state = LocalUser(
      id: response.docs[0].id, 
      user: FirebaseUser.fromMap(response.docs[0].data() as Map<String, dynamic>)
    );
  }

    //CRUD
    //1.  ********************************** Create  *********************************
  Future<void> signUp(String email) async {

    DocumentReference response = await _firestore
        .collection("users")
        .add(
          FirebaseUser(
            email: email, 
            name: "No Name", 
            profilePic: "https://picsum.photos/200/300?grayscale")
          .toMap(),
        );
  // ********************************* End of create *********************************


  // 2.  ********************************* Read *********************************
        DocumentSnapshot snapshot = await response.get();

  // ********************************* End of Read *********************************

    state = LocalUser(id: response.id, user: FirebaseUser.fromMap(snapshot.data() as Map<String, dynamic>));
  }

  //3. ********************************* Update *********************************
  Future<void> updateName(String name) async {
    await _firestore
        .collection("users")
        .doc(state.id)
        .update({"name": name});

  //updating the local userstate
    state = state.copyWith(user: state.user.copyWith(name: name));
  }

  // ********************************* End of Update *********************************


  void logout() {
    state = const LocalUser(
      id: 'error', 
      user: FirebaseUser(
        email: 'error', 
        name: 'error', 
        profilePic: 'error',
      ),
    );
  }
}

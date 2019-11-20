import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifeschool/services/user/model/user.dart';

enum UserProperty { FIRST_NAME, LAST_NAME, PHOTO_ID, PHONE, EMAIL }

class UserRepository {
  Firestore _firestore;

  UserRepository(this._firestore);

  Future<User> storeNewUser(data) {
    return _firestore.collection('/users').document(data["id"]).setData({
      'email': data["email"],
      'uid': data["id"],
      'firstName': data["firstName"],
      'lastName': data["lastName"],
      'imageUrl': data["imageUrl"],
    }, merge: true ).catchError((e) {
      print(e);
    });
  }

  Future<User> getUser(String uid) async {
    final data = await _firestore.collection('/users').where("uid", isEqualTo: uid).snapshots().first;
    if (data.documents.length == 0) return null;

    final snapshot = data.documents[0].data;
    return User((b) => b
      ..firstName = snapshot["firstName"]
      ..lastName = snapshot["lastName"]
      ..email = snapshot["email"]
      ..imageUrl = snapshot["imageUrl"]
      ..id = snapshot["id"]);
  }
}

import 'package:lifeschool/data/firebase_base_repository.dart';
import 'package:lifeschool/profile/model/user.dart';
import 'package:lifeschool/profile/repository/user_repository.dart';
import 'package:rxdart/rxdart.dart';

class FirebaseUserRepository implements UserRepository {
  FirebaseBaseRepository _firebaseBaseRepository;

  FirebaseUserRepository(this._firebaseBaseRepository);

  @override
  Observable<String> getCurrentUserImageId(String userId) {
    return _firebaseBaseRepository.observeValue<String>("user/$userId/imageId");
  }

  @override
  Observable<User> getCurrentUser(String userId) {
    return _firebaseBaseRepository
        .observeSnapshot("user/$userId")
        .map((snapshot) => snapshot.value)
        .map((data) => _userFromData(data, userId));
  }

  User _userFromData(dynamic data, String userId) {
    return User((b) => b
      ..firstName = data["first_name"]
      ..lastname = data["last_name"]
      ..email = data["email"]
      ..imageId = data["imageId"]
      ..phone = data["phone"]
      ..id = userId);
  }

  @override
  Future<void> setUserProperty(String userId, UserProperty property, String value) {
    var path;
    switch (property) {
      case UserProperty.FIRST_NAME:
        path = "first_name";
        break;
      case UserProperty.LAST_NAME:
        path = "last_name";
        break;
      case UserProperty.PHONE:
        path = "phone";
        break;
      case UserProperty.EMAIL:
        path = "email";
        break;
      case UserProperty.PHOTO:
        path = "photo";
        break;
    }

    return _firebaseBaseRepository.writeValue("user/$userId/$path", value);
  }

  @override
  Future<String> getPropertyForUser(String userId, String propertyName) =>
      _firebaseBaseRepository.observeValue<String>("user/$userId/$propertyName").first;
}

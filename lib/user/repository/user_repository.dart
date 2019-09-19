import 'package:rxdart/rxdart.dart';
import 'package:lifeschool/user/model/user.dart';

abstract class UserRepository {
  Observable<String> getCurrentUserImageId(String userId);

  Future<void> setUserProperty(String userId, UserProperty property, String value);

  Future<String> getPropertyForUser(String userId, String propertyName);

  Observable<User> getCurrentUser(String userId);
}

enum UserProperty { FIRST_NAME, LAST_NAME, PHOTO, PHONE, EMAIL }

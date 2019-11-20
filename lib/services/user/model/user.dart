library user;

import 'package:built_value/built_value.dart';

part 'user.g.dart';

// Built with built_value. Command to generate files:
// flutter packages pub run build_runner build

abstract class User implements Built<User, UserBuilder> {
  String get id;
  String get firstName;
  String get lastName;
  String get imageUrl;

  @nullable
  String get phone;

  @nullable
  String get email;

  factory User([updates(UserBuilder b)]) = _$User;

  User._();
}

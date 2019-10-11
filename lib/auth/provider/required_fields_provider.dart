import 'package:lifeschool/data/firebase_base_repository.dart';

class RequiredFieldsProvider extends FirebaseBaseRepository {
  Set<String> _requiredFields;

  RequiredFieldsProvider(_database) : super(_database);

  Future<Set<String>> get requiredFields async {
    if (_requiredFields != null) {
      return Set.of(_requiredFields);
    }
    final String value = await observeValue<String>("config/required_fields").first;
    _requiredFields = value.split(",").toSet();
    return Set.of(_requiredFields);
  }
}

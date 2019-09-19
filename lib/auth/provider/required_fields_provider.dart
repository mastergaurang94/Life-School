import 'package:lifeschool/data/firebase_base_repository.dart';

class RequiredFieldsProvider {
  Set<String> _requiredFields;
  FirebaseBaseRepository firebaseBaseRepository;

  RequiredFieldsProvider(this.firebaseBaseRepository);

  Future<Set<String>> get requiredFields async {
    if (_requiredFields != null) {
      return Set.of(_requiredFields);
    }
    final String value =
    await firebaseBaseRepository.observeValue<String>("config/required_fields").first;
    _requiredFields = value.split(",").toSet();
    return Set.of(_requiredFields);
  }
}
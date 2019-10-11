import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/rxdart.dart';

class FirebaseBaseRepository {
  FirebaseDatabase _database;

  FirebaseBaseRepository(this._database);

  Future<void> writeValue<T>(String path, T value) {
    return _database.reference().child(path).set(value);
  }

  Observable<T> observeValue<T>(String path) {
    return Observable(_database.reference().child(path).onValue).map((event) => event.snapshot.value as T);
  }

  String getNewNode(String path) {
    return _database.reference().child(path).push().key;
  }

  Observable<DataSnapshot> observeSnapshot(String path) {
    return Observable(_database.reference().child(path).onValue).map((event) => event.snapshot).onErrorResume((error) {
      return new Observable.error(error);
    });
  }

  Observable<List<String>> observeKeys(String path) {
    return observeSnapshot(path).map((snapshot) {
      final data = snapshot.value;
      if (data == null) {
        return List.from([]);
      } else {
        return List.from(data.keys);
      }
    });
  }
}

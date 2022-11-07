import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String email;
  DatabaseService(this.email);
  final CollectionReference userToDos =
      FirebaseFirestore.instance.collection('userToDos');

  Future setToDo(String item, bool value) async {
    return await userToDos
        .doc(email)
        .set({item: value}, SetOptions(merge: true));
  }

  Future deleteToDo(String key) async {
    return await userToDos.doc(email).update({
      key: FieldValue.delete(),
    });
  }

  Future checkIfUserExists() async {
    if ((await userToDos.doc(email).get()).exists) {
      return true;
    } else {
      return false;
    }
  }

  Stream<DocumentSnapshot<Object?>> getToDos() {
    return userToDos.doc(email).snapshots();
  }
}

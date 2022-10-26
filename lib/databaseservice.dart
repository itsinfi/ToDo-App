import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String userID;
  DatabaseService(this.userID);
  final CollectionReference userToDos =
      FirebaseFirestore.instance.collection('userToDos');

  Future setToDo(String item, bool value) async {
    return await userToDos
        .doc(userID)
        .set({item: value}, SetOptions(merge: true));
  }

  Future deleteToDo(String key) async {
    return await userToDos.doc(userID).update({
      key: FieldValue.delete(),
    });
  }

  Future checkIfUserExists() async {
    if ((await userToDos.doc(userID).get()).exists) {
      return true;
    } else {
      return false;
    }
  }

  Stream<DocumentSnapshot<Object?>> getToDos() {
    return userToDos.doc(userID).snapshots();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String userID;

  DatabaseService(this.userID);

  final CollectionReference userToDos =
      FirebaseFirestore.instance.collection('userToDos');

  Stream<DocumentSnapshot<Object?>> getTodos() {
    return userToDos.doc('VkAiV0RKoyNe9MOaJw91').snapshots();
  }

  Future setTodo(String item, bool value) async {
    return await userToDos
        .doc('VkAiV0RKoyNe9MOaJw91')
        .set({item: value}, SetOptions(merge: true));
  }

  Future deleteTodo(String key) async {
    return await userToDos.doc('VkAiV0RKoyNe9MOaJw91').update({
      key: FieldValue.delete(),
    });
  }

  Future deleteAllTodos(key) async {
    await userToDos.doc('VkAiV0RKoyNe9MOaJw91').delete();
  }

  Future checkIfUserExists() async {
    if ((await userToDos.doc(userID).get()).exists) {
      return true;
    } else {
      return false;
    }
  }
}

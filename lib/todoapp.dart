import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'entry.dart';
import 'databaseservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class ToDoApp extends StatefulWidget {
  late String userid;
  ToDoApp(this.userid, {super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  late User user;
  late DatabaseService database;
  final GlobalKey<FormState> formkey = GlobalKey();
  String? item;

  void addEntry(String key) {
    setState(() {
      database.setToDo(key, false);
    });
    Navigator.of(context).pop();
  }

  void save() {
    if (formkey.currentState!.validate()) {
      addEntry(item!);
    }
  }

  void newEntry() {
    showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Was für eine Erinnerung willst du hinzufügen?"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Form(
                  key: formkey,
                  child: TextFormField(
                    onChanged: (txt) {
                      item = txt;
                    },
                    onFieldSubmitted: (txt) {
                      save;
                    },
                    validator: (txt) {
                      if (txt!.isEmpty || item!.startsWith(" ")) {
                        return "Bitte einen Wert hinzufügen.";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: "Erinnerung",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: 20,
                ),
                SizedBox(
                  width: 150,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: save,
                    child: const Text(
                      "Speichern",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Franklin Gothic Demi Cont",
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void deleteEntry(String key) {
    database.deleteToDo(key);
  }

  void toggleCheck(String key, bool check) {
    setState(() {
      database.setToDo(key, !check);
    });
  }

  Widget entryList(Map<String, dynamic> entries) {
    if (entries.isNotEmpty) {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        itemCount: entries.length,
        itemBuilder: (context, i) {
          String key = entries.keys.elementAt(i);
          if (!(key ==
              '"?§()%&/?"()%/?§"(/?="§/&"§=(%/&=(§%&/="§(%/&=(§"&/"§=(%&/(§=%/(="%§?&(=/?"§%&/(?"§?&(/"§?%(&/')) {
            return Padding(
              padding: const EdgeInsets.all(2),
              child: Entry(
                key,
                entries[key]!,
                () {
                  deleteEntry(key);
                },
                () {
                  toggleCheck(key, entries[key]!);
                },
              ),
            );
          } else {
            return Container(
              color: Colors.transparent,
              width: 0,
              height: 0,
            );
          }
        },
      );
    } else {
      return Container(color: const Color.fromRGBO(70, 70, 70, 1));
    }
  }

  Future<void> connectToFirebase() async {
    await Firebase.initializeApp();
    final FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential result = await auth.signInAnonymously();
    user = result.user!;
    database = DatabaseService(widget.userid);
    if (!(await database.checkIfUserExists())) {
      database.setToDo(
          '"?§()%&/?"()%/?§"(/?="§/&"§=(%/&=(§%&/="§(%/&=(§"&/"§=(%&/(§=%/(="%§?&(=/?"§%&/(?"§?&(/"§?%(&/',
          false);
    }
    Stream userDocumentStream = database.getToDos();
    userDocumentStream.listen((documentSnapshot) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ToDo',
          style: TextStyle(
            fontFamily: "Franklin Gothic Demi Cond",
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: const Color.fromRGBO(70, 70, 70, 1),
      body: FutureBuilder(
          future: connectToFirebase(),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return StreamBuilder<DocumentSnapshot>(
                stream: (database.getToDos()),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    Map<String, dynamic> entries =
                        snapshot.data?.data() as Map<String, dynamic>;
                    return entryList(entries);
                  }
                },
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: newEntry,
        child: const Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}

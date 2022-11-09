import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'entry.dart';
import 'databaseservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'frontpage.dart';
import 'helpscreen.dart';
import 'accountinfoscreen.dart';

// ignore: must_be_immutable
class ToDoApp extends StatefulWidget {
  final String email;
  final bool isLogin;
  final UserCredential result;
  final FirebaseAuth auth;
  ToDoApp(this.email, this.isLogin, this.result, this.auth, {super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  late User user;
  late DatabaseService database;
  final GlobalKey<FormState> formkey = GlobalKey();
  ScrollController controller = new ScrollController();
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

  void toggleCheck(String key, bool check) {
    setState(() {
      database.setToDo(key, !check);
    });
  }

  Future<void> SignOut() async {
    await widget.auth.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => (LogInPage()))));
  }

  Widget NewEntryButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Color.fromRGBO(0, 200, 0, 1),
        child: SizedBox(
          width: 30,
          height: 30,
          child: IconButton(
            onPressed: newEntry,
            padding: EdgeInsets.zero,
            icon: Icon(Icons.add, size: 25),
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget HelpScreenButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Color.fromRGBO(0, 0, 0, 0.1),
        child: SizedBox(
          width: 30,
          height: 30,
          child: IconButton(
            onPressed: () {
              Navigator.push<Widget>(
                  context,
                  MaterialPageRoute<Widget>(
                    builder: (context) => HelpScreen(),
                  ));
            },
            icon: Icon(Icons.question_mark, size: 20),
            padding: EdgeInsets.zero,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget ViewAccountButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Color.fromRGBO(0, 0, 0, 0.1),
        child: SizedBox(
          width: 35,
          height: 35,
          child: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AccountInfoScreen(
                      widget.email, widget.result, widget.auth)));
            },
            padding: EdgeInsets.zero,
            icon: Icon(Icons.account_box, size: 30),
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget entryList(Map<String, dynamic> entries, DatabaseService database) {
    if (entries.isNotEmpty) {
      return ListView.builder(
        physics: BouncingScrollPhysics(),
        controller: controller,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        itemCount: entries.length,
        itemBuilder: (context, i) {
          String key = entries.keys.elementAt(i);
          if (!(key ==
              '"?§()%&/?"()%/?§"(/?="§/&"§=(%/&=(§%&/="§(%/&=(§"&/"§=(%&/(§=%/(="%§?&(=/?"§%&/(?"§?&(/"§?%(&/')) {
            return Column(children: [
              Padding(
                padding: const EdgeInsets.all(2),
                child: Entry(key, entries[key]!, () {
                  toggleCheck(key, entries[key]!);
                }, database: database),
              ),
            ]);
          } else {
            return Container(
              color: Colors.transparent,
            );
          }
        },
      );
    } else {
      return Container(color: const Color.fromRGBO(70, 70, 70, 1));
    }
  }

  Future<void> connectToFirebase() async {
    user = widget.result.user!;
    database = DatabaseService(widget.email);
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
          'ToDos',
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
                  return entryList(entries, database);
                }
              },
            );
          }
        },
      ),
      bottomNavigationBar: Container(
        height: 45,
        color: Color.fromRGBO(103, 58, 183, 0.8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            HelpScreenButton(),
            ViewAccountButton(),
            NewEntryButton(),
          ],
        ),
      ),
    );
  }
}

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

  Future<void> SignOut() async {
    await widget.auth.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => (LogInPage()))));
  }

  Widget LogOutButton() {
    return ElevatedButton(
      onPressed: SignOut,
      child: Text(
        'Abmelden.',
        style: TextStyle(
            color: Colors.white,
            fontFamily: "Franklin Gothic Demi Cont",
            fontSize: 20,
            fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget entryList(Map<String, dynamic> entries) {
    if (entries.isNotEmpty) {
      return ListView.builder(
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
    //String userid = user.uid;
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
      body: /*ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
        color: Colors.transparent,
        height: 20,
      ),*/
          Column(
        children: [
          /*Row(
            children: [*/
          //Text(widget.result.user.toString()),
          SizedBox(
            width: double.infinity,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(Icons.account_box, size: 70),
              onPressed: () {
                MaterialPageRoute<Widget>(
                  builder: (context) => AccountInfoScreen(),
                );
              },
            ),
          ),
          /* ],
          ),*/
          FutureBuilder(
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
            },
          ),
        ],
      ),
      /*],
      ),*/
      bottomNavigationBar: /* BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Einstellungen'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
        ],
        onTap
      ),*/
          Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          /*Text('Hallo $userid! Irgendwelche Fragen? Klick hier:'),*/
          ClipRRect(
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
          ),
          LogOutButton(),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: Color.fromRGBO(0, 0, 0, 0.1),
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
          ),
        ],
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: newEntry,
        child: const Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),*/
    );
  }
}

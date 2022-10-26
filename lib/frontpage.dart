import 'package:flutter/material.dart';
import 'todoapp.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({super.key});

  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  late String userid;

  final GlobalKey<FormState> formkey = GlobalKey();

  void save() {
    if (formkey.currentState!.validate()) {
      Navigator.push<Widget>(
          context,
          MaterialPageRoute<Widget>(
            builder: (context) => ToDoApp(userid),
          ));
    }
  }

  void logInDialog() {
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("LogIn?"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Form(
                key: formkey,
                child: TextFormField(
                  onChanged: (txt) {
                    userid = txt;
                  },
                  onFieldSubmitted: (txt) {
                    save;
                  },
                  validator: (txt) {
                    if (txt!.isEmpty || userid.startsWith(" ")) {
                      return "Bitte einen Wert hinzufügen.";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "LogIn-Name",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                height: 20,
              ),
              SizedBox(
                width: 200,
                height: 40,
                child: ElevatedButton(
                  onPressed: save,
                  child: const Text(
                    "Einloggen",
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
      },
    );
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
      body: Container(
        color: const Color.fromRGBO(70, 70, 70, 1),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: logInDialog,
        child: const Icon(Icons.account_circle_outlined),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}

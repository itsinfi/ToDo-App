import 'package:cloud_firestore/cloud_firestore.dart';
import 'todoapp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'resetsendemailscreen.dart';
//import 'verifyemailpage.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  late String email;
  late String password;

  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void save(UserCredential result, bool isFirstLogIn) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: ((context) => (ToDoApp(
            controllerEmail.text, isLogin, result, auth, isFirstLogIn)))));
  }

/*  void verify(UserCredential result) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: ((context) => (VerifyEmailPage(email: email)))));
  }*/

  Future<void> LogIn() async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential result = await auth.signInWithEmailAndPassword(
            email: controllerEmail.text, password: controllerPassword.text);
        save(result, false);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> SignIn() async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential result = await auth.createUserWithEmailAndPassword(
            email: controllerEmail.text, password: controllerPassword.text);
        save(result, true);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget ErrorMesage() {
    print(errorMessage);
    return Text(
      errorMessage == '' ? '' : 'Error: $errorMessage',
      style: TextStyle(color: Colors.red),
    );
  }

  Widget TextWidget(String text, String titel, TextEditingController controller,
      bool isEmail) {
    return TextFormField(
      onChanged: (txt) {
        text = txt;
      },
      obscureText: !isEmail,
      onFieldSubmitted: (txt) {
        isLogin ? LogIn : SignIn;
        ;
      },
      controller: controller,
      keyboardType:
          isEmail ? TextInputType.emailAddress : TextInputType.visiblePassword,
      decoration: InputDecoration(
        hoverColor: Colors.white,
        hintText: isEmail ? 'Email eingeben...' : 'Passwort eingeben...',
        labelText: titel,
        focusColor: Colors.deepPurple,
        fillColor: Colors.white,
        prefixIcon: Icon(isEmail ? Icons.email : Icons.password),
        iconColor: Colors.white,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple, width: 2.0)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 2.0)),
      ),
    );
  }

  Widget SubmitButton() {
    return ElevatedButton(
        onPressed: isLogin ? LogIn : SignIn,
        child: Text(
          isLogin ? 'Anmelden.' : 'Registrieren.',
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Franklin Gothic Demi Cont",
              fontSize: 20,
              fontWeight: FontWeight.w400),
        ));
  }

  Widget LogSignButton() {
    return TextButton(
        onPressed: () {
          setState(() {
            isLogin = !isLogin;
          });
        },
        child: Text(isLogin
            ? 'Neuen Account erstellen?'
            : 'Mit bestehendem Account anmelden?'));
  }

  void PasswordResetQuestion() {
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Soll dein Passwort zurückgesetzt werden?"),
          content: Container(
            color: Colors.white,
            child: Row(
              children: <TextButton>[
                TextButton(
                    onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => ResetSendEmailScreen())),
                    child: Text('Passwort zurücksetzen')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Abbrechen')),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget PasswordResetButton() {
    if (isLogin &&
        errorMessage?.trim() ==
            'The password is invalid or the user does not have a password.') {
      return TextButton(
          onPressed: PasswordResetQuestion,
          child: Text(
            'Ich habe mein Kennwort vergessen.',
          ));
    } else {
      return Container(
        color: Colors.transparent,
        height: 0,
        width: 0,
      );
    }
  }

  Widget logInDialog() {
    return Container(
      color: Colors.white,
      height: 400,
      width: 500,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            color: Colors.white,
          ),
          Center(
            child: Text(
              isLogin ? 'Anmeldung' : 'Registrierung',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 40,
                fontFamily: 'Franklin Gothic Demi Cond',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            color: Colors.transparent,
            height: 5,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextWidget(email, 'Email', controllerEmail, true),
              Container(
                color: Colors.transparent,
                height: 10,
              ),
              TextWidget(password, 'Passwort', controllerPassword, false),
            ],
          ),
          Container(
            color: Colors.transparent,
            height: 20,
          ),
          ErrorMesage(),
          PasswordResetButton(),
          SizedBox(
            width: 200,
            height: 40,
            child: SubmitButton(),
          ),
          LogSignButton(),
        ],
      ),
    );
  }

  @override
  void initState() {
    email = "Email";
    password = "Passwort";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'check.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Franklin Gothic Demi Cond",
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: const Color.fromRGBO(70, 70, 70, 1),
      body: ListView(
        children: [
          Column(
            children: <Widget>[
              Container(
                height: 20,
                color: Colors.transparent,
              ),
              Image(image: AssetImage("assets/images/check2.png")),
              Container(
                height: 50,
                color: Colors.transparent,
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: Center(child: logInDialog()),
                color: const Color.fromRGBO(70, 70, 70, 1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

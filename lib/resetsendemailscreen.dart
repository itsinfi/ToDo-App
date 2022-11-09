import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolist/frontpage.dart';
import 'checkemailpage.dart';

class ResetSendEmailScreen extends StatefulWidget {
  ResetSendEmailScreen({super.key});

  @override
  State<ResetSendEmailScreen> createState() => _ResetSendEmailScreenState();
}

class _ResetSendEmailScreenState extends State<ResetSendEmailScreen> {
  late String email;

  final TextEditingController controllerEmail = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? errorMessage = '';

  Future<void> SendEmail() async {
    try {
      if (email.isNotEmpty) {
        await auth.sendPasswordResetEmail(email: controllerEmail.text);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: ((context) => CheckEmailPage())));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget TextWidget(String text, String titel, TextEditingController controller,
      bool isFirst) {
    return TextFormField(
      onChanged: (txt) {
        email = text;
        text = txt;
      },
      obscureText: false,
      onFieldSubmitted: (txt) {
        SendEmail;
        ;
      },
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hoverColor: Colors.white,
        hintText: 'Email zum Zurücksetzen...',
        labelText: titel,
        focusColor: Colors.deepPurple,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.email),
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
        onPressed: SendEmail,
        child: Text(
          'Anfrage senden?',
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Franklin Gothic Demi Cont",
              fontSize: 20,
              fontWeight: FontWeight.w400),
        ));
  }

  Widget CancelButton() {
    return TextButton(
        onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LogInPage())),
        child: Text('Passwort zurücksetzen abbrechen?'));
  }

  Widget ErrorMesage() {
    print(errorMessage);
    return Text(
      errorMessage == '' ? '' : 'Error: $errorMessage',
      style: TextStyle(color: Colors.red),
    );
  }

  Widget PasswordResetDialog() {
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
              'Passwort zurücksetzen',
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
          TextWidget(email, 'Email eingeben', controllerEmail, true),
          Container(
            color: Colors.transparent,
            height: 20,
          ),
          ErrorMesage(),
          SizedBox(
            width: 400,
            height: 40,
            child: SubmitButton(),
          ),
          CancelButton(),
        ],
      ),
    );
  }

  @override
  void initState() {
    email = "Email";
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
                child: Center(child: PasswordResetDialog()),
                color: const Color.fromRGBO(70, 70, 70, 1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetScreen extends StatefulWidget {
  ResetScreen({super.key});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  late String password1, password2;

  final TextEditingController controllerPassword1 = TextEditingController();
  final TextEditingController controllerPassword2 = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? errorMessage = '';

  void ChangePassword() {
    if (password1 == password2) {
      setState(() {
        errorMessage = '';
      });
      auth.confirmPasswordReset(code: code, newPassword: password1);
    } else {
      setState(() {
        errorMessage = 'Die Passwörter stimmen nicht miteinander überein.';
      });
      ;
    }
  }

  Widget TextWidget(String text, String titel, TextEditingController controller,
      bool isFirst) {
    return TextFormField(
      onChanged: (txt) {
        isFirst ? password1 = text : password2 = text;
        text = txt;
      },
      obscureText: true,
      onFieldSubmitted: (txt) {
        ChangePassword;
        ;
      },
      controller: controller,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        hoverColor: Colors.white,
        hintText:
            isFirst ? 'Passwort eingeben...' : 'Passwort nochmal eingeben...',
        labelText: titel,
        focusColor: Colors.deepPurple,
        fillColor: Colors.white,
        prefixIcon: Icon(Icons.password),
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
        onPressed: ChangePassword,
        child: Text(
          'Passwort zurücksetzen.',
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
            MaterialPageRoute(builder: (context) => ResetScreen())),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextWidget(
                  password1, 'Passwort eingeben', controllerPassword1, true),
              Container(
                color: Colors.transparent,
                height: 10,
              ),
              TextWidget(password2, 'Passwort erneut eingeben',
                  controllerPassword2, false),
            ],
          ),
          Container(
            color: Colors.transparent,
            height: 20,
          ),
          ErrorMesage(),
          SizedBox(
            width: 200,
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
    password1 = "Passwort";
    password2 = "Passwort";
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
              Image(image: AssetImage("images/check2.png")),
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
}*/

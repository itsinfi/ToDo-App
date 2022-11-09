import 'package:flutter/material.dart';
import 'frontpage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountInfoScreen extends StatefulWidget {
  final String email;
  final UserCredential result;
  final FirebaseAuth auth;
  const AccountInfoScreen(this.email, this.result, this.auth, {super.key});

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
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

  @override
  Widget build(BuildContext context) {
    String emailplaceholder = widget.email;
    return Scaffold(
      appBar: AppBar(
        title: Text('User-Info'),
        backgroundColor: Color.fromRGBO(70, 70, 70, 1),
      ),
      body: Container(
        padding: EdgeInsets.all(27),
        color: Color.fromRGBO(70, 70, 70, 1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                ),
                height: 120,
                width: 120,
                child: Container(
                  color: Colors.transparent,
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Icon(
                      Icons.account_box,
                      size: 100,
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dein Account:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Franklin Gothic Demi Cond',
                        fontSize: 20),
                  ),
                  Container(
                    height: 20,
                    color: Colors.transparent,
                  ),
                  Text(
                    '$emailplaceholder',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Franklin Gothic Demi Cond',
                        fontSize: 20),
                  ),
                ],
              ),
              LogOutButton(),
            ],
          ),
        ),
      ),
      backgroundColor: Color.fromRGBO(70, 70, 70, 1),
    );
  }
}

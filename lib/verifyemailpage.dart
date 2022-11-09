/*import 'package:flutter/material.dart';
import 'frontpage.dart';

class VerifyEmailPage extends StatelessWidget {
  final String email;
  const VerifyEmailPage({
    super.key,
    required this.email,
  });

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
                color: const Color.fromRGBO(70, 70, 70, 1),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 30,
                        color: Colors.transparent,
                      ),
                      Text(
                        'Wir haben dir eine Email an $email zum Verifizieren deiner Email gesendet. Verfiziere deine Email und melde dich neu an um fortzufahren!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Franklin Gothic Demi Cond',
                            fontSize: 20),
                      ),
                      Container(
                        height: 70,
                        color: Colors.transparent,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => LogInPage()));
                        },
                        child: Text(
                          'Zurück zum LogIn',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Franklin Gothic Demi Cond',
                              fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}*/

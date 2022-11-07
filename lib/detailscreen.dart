import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen(this.entry, this.check, {super.key});
  final String entry;
  final bool check;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: check ? Colors.green : Colors.red,
      appBar: AppBar(
        title: Text(entry),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Text(
                  check
                      ? 'Das hast du schon erledigt:'
                      : 'Das musst du noch machen:',
                  style: const TextStyle(
                      fontSize: 30,
                      fontFamily: "Franklin Gothic Demi Cont",
                      fontWeight: FontWeight.w200,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Center(
              child: Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                  child: Text(
                    entry,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 40,
                        fontFamily: "Franklin Gothic Demi Cont",
                        fontWeight: FontWeight.w200,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: IconButton(
                iconSize: 60,
                onPressed: () => Navigator.pop(context),
                icon: Icon(check ? Icons.check : Icons.close,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

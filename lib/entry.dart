import 'package:flutter/material.dart';
import 'detailscreen.dart';

class Entry extends StatelessWidget {
  final String item;
  final bool check;
  final Function deleteEntry;
  final Function toggleCheck;
  const Entry(this.item, this.check, this.deleteEntry, this.toggleCheck,
      {super.key});

  Widget textFormat() {
    if (check == false) {
      return Text(
        item,
        style: const TextStyle(
            color: Colors.white,
            fontFamily: "Franklin Gothic Demi Cond",
            fontWeight: FontWeight.w400,
            fontSize: 16),
      );
    } else {
      return Text(
        item,
        style: const TextStyle(
            color: Colors.white70,
            decoration: TextDecoration.lineThrough,
            decorationColor: Color.fromRGBO(0, 255, 0, 1),
            decorationThickness: 2,
            fontFamily: "Franklin Gothic Demi Cond",
            fontWeight: FontWeight.w400,
            fontSize: 16),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: check,
        onChanged: (var checkmark) {
          toggleCheck();
        },
        activeColor: const Color.fromRGBO(103, 58, 183, 1),
        checkColor: const Color.fromRGBO(0, 255, 60, 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      title: textFormat(),
      trailing: Wrap(
        children: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push<Widget>(
                  context,
                  MaterialPageRoute<Widget>(
                    builder: (context) => DetailScreen(item, check),
                  ));
            },
            icon: const Icon(Icons.info_outline),
          ),
          IconButton(
            onPressed: () {
              deleteEntry();
            },
            icon: const Icon(Icons.delete_outlined),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: const BorderSide(
          color: Color.fromRGBO(90, 90, 90, 1),
          width: 2,
        ),
      ),
    );
  }
}

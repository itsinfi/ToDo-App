import 'package:flutter/material.dart';
import 'detailscreen.dart';
import 'databaseservice.dart';

// ignore: must_be_immutable
class Entry extends StatefulWidget {
  late final String item;
  final bool check;
  final Function deleteEntry;
  final Function toggleCheck;
  final DatabaseService database;
  final GlobalKey<FormState> formkey = GlobalKey();
  Entry(
    this.item,
    this.check,
    this.deleteEntry,
    this.toggleCheck, {
    super.key,
    required this.database,
  });

  @override
  State<Entry> createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  Widget textFormat() {
    if (widget.check == false) {
      return Text(
        widget.item,
        style: const TextStyle(
            color: Colors.white,
            fontFamily: "Franklin Gothic Demi Cond",
            fontWeight: FontWeight.w400,
            fontSize: 16),
      );
    } else {
      return Text(
        widget.item,
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

  void save(String txt) {
    //setState(() {
    widget.deleteEntry(widget.item);
    widget.database.setToDo(txt, widget.check);
    Navigator.of(context).pop();
    //});
    print('hallo');
  }

  void EntryItemChange() {
    showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) {
          String txt = '';
          return AlertDialog(
            title: const Text("Wie willst du die Erinnerung umbenennen?"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Form(
                  key: widget.formkey,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: widget.item,
                      labelText: 'Neuer Name',
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.purple, width: 2.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.0)),
                    ),
                    style: const TextStyle(
                        fontFamily: "Franklin Gothic Demi Cond",
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                    onChanged: (value) {
                      txt = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Die Erinnerung darf nicht leer sein.';
                      } else {
                        return null;
                      }
                    },
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
                    onPressed: () {
                      if (widget.formkey.currentState!.validate()) {
                        save(txt);
                      }
                    },
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

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Color.fromRGBO(65, 65, 65, 1),
      onTap: () {
        EntryItemChange();
      },
      leading: Checkbox(
        value: widget.check,
        onChanged: (var checkmark) {
          widget.toggleCheck();
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
                    builder: (context) =>
                        DetailScreen(widget.item, widget.check),
                  ));
            },
            icon: const Icon(Icons.info_outline),
          ),
          IconButton(
            onPressed: () {
              widget.deleteEntry();
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

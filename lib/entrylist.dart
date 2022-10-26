// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'entry.dart';

class EntryList extends StatefulWidget {
  final String keey;
  Map<String, bool> entrys = {};
  EntryList(this.keey, this.entrys, {super.key});

  @override
  State<EntryList> createState() => _EntryListState();
}

class _EntryListState extends State<EntryList> {
  void deleteEntry(String keey) {
    setState(() {
      widget.entrys.remove(keey);
    });
  }

  void toggleCheck(String keey) {
    setState(() {
      widget.entrys.update(keey, (bool check) => !check);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.entrys.isNotEmpty) {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        itemCount: widget.entrys.length,
        itemBuilder: (context, i) {
          String key = widget.entrys.keys.elementAt(i);
          return Padding(
            padding: const EdgeInsets.all(2),
            child: Entry(widget.keey, widget.entrys[key]!, () {
              deleteEntry(widget.keey);
            }, () {
              toggleCheck(widget.keey);
            }),
          );
        },
      );
    } else {
      return Container(color: const Color.fromRGBO(70, 70, 70, 1));
    }
  }
}

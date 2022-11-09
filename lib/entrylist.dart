import 'package:flutter/material.dart';
import 'entry.dart';
import 'databaseservice.dart';

class EntryList extends StatefulWidget {
  final Map<String, dynamic> entries;
  final DatabaseService database;
  final bool needHelp;

  const EntryList(this.entries, this.database, this.needHelp, {super.key});

  @override
  State<EntryList> createState() => _EntryListState();
}

class _EntryListState extends State<EntryList> {
  ScrollController controller = new ScrollController();
  void toggleCheck(String key, bool check) {
    setState(() {
      widget.database.setToDo(key, !check);
    });
  }

  Widget entryListWithoutHelp(
      Map<String, dynamic> entries, DatabaseService database) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        controller: controller,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        itemCount: entries.length,
        itemBuilder: (context, i) {
          String key = entries.keys.elementAt(i);
          if (!(key ==
              '"?§()%&/?"()%/?§"(/?="§/&"§=(%/&=(§%&/="§(%/&=(§"&/"§=(%&/(§=%/(="%§?&(=/?"§%&/(?"§?&(/"§?%(&/')) {
            return Column(children: [
              Padding(
                padding: const EdgeInsets.all(2),
                child: Entry(key, entries[key]!, () {
                  toggleCheck(key, entries[key]!);
                }, database: database),
              ),
            ]);
          } else {
            return Container(color: const Color.fromRGBO(70, 70, 70, 1));
          }
        });
  }

  Widget entryListWithHelp(
      Map<String, dynamic> entries, DatabaseService database) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      controller: controller,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      itemCount: entries.length,
      itemBuilder: (context, i) {
        String key = entries.keys.elementAt(i);
        if (entries.length == 2) {
          if (!(key ==
              '"?§()%&/?"()%/?§"(/?="§/&"§=(%/&=(§%&/="§(%/&=(§"&/"§=(%&/(§=%/(="%§?&(=/?"§%&/(?"§?&(/"§?%(&/')) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Entry(key, entries[key]!, () {
                    toggleCheck(key, entries[key]!);
                  }, database: database),
                ),
                Container(
                  color: Colors.transparent,
                  height: 5,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 270,
                          child: Text(
                            'Hier ist dein erster Eintrag. Klicke auf das i um mehr Infos zu erhalten. Tippe auf die Checkbox um den Eintrag als "erledigt" zu markieren. Drücke auf das Mülleimer-Icon, um den Eintrag zu löschen und auf den Eintrag selber, um ihn umzubenenen.',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Franklin Gothic Demi Cont",
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Icon(
                          Icons.arrow_upward_rounded,
                          color: Colors.white,
                          size: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Container(
              color: Colors.transparent,
            );
          }
        } else {
          if (!(key ==
              '"?§()%&/?"()%/?§"(/?="§/&"§=(%/&=(§%&/="§(%/&=(§"&/"§=(%&/(§=%/(="%§?&(=/?"§%&/(?"§?&(/"§?%(&/')) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Entry(key, entries[key]!, () {
                    toggleCheck(key, entries[key]!);
                  }, database: database),
                ),
              ],
            );
          } else {
            return Container(
              color: Colors.transparent,
              height: (MediaQuery.of(context).size.height - 165),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Colors.green,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 270,
                            child: Text(
                              'Hier klicken, um zu starten und ein neues Item hinzuzufügen',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Franklin Gothic Demi Cont",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Icon(
                            Icons.arrow_downward_rounded,
                            color: Colors.white,
                            size: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.entries.isNotEmpty) {
      if (widget.needHelp) {
        return entryListWithHelp(widget.entries, widget.database);
      } else {
        return entryListWithoutHelp(widget.entries, widget.database);
      }
    } else {
      return Container(
        color: Color.fromRGBO(70, 70, 70, 1),
      );
    }
  }
}

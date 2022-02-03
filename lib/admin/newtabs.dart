// import 'package:Score_Dekho/admin/Inng2Tab.dart';
// import 'package:Score_Dekho/admin/squads.dart';
import 'package:flutter/material.dart';
import 'package:my_score_app/admin/squads.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Inng1Tab.dart';
import 'Inng2Tab.dart';

// import 'Inng1Tab.dart';

class NewTabs extends StatefulWidget {
  const NewTabs(
      {Key? key,
      required this.selector,
      required this.team1,
      required this.team2})
      : super(key: key);
  final String selector;
  final String team1;
  final String team2;
  static bool status = true;

  @override
  _NewTabsState createState() => _NewTabsState();
}

class _NewTabsState extends State<NewTabs> {
  String result = "";
  

  updateMessage() {
    var documentReference =
        FirebaseFirestore.instance.collection("Matches").doc(widget.selector);

    Map<String, dynamic> msg = {"Result": result};
    documentReference.update(msg);
  }

  updateliveColor() {
    var documentReference = FirebaseFirestore.instance
        .collection("Matches")
        .doc(widget.selector);

    Map<String, dynamic> livestatus = {"status": NewTabs.status};
    documentReference.update(livestatus).then((value) => debugPrint("updated"));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple,
            centerTitle: true,
            title: Text('Match ${widget.selector}'),
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  child: Text('Squads'),
                ),
                Tab(
                  child: Text('Ing 1'),
                ),
                Tab(
                  child: Text('Ing 2'),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.live_tv_rounded),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Change Status"),
                          content: SizedBox(
                            height: 50.0,
                            child: Column(
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      hintText: "write true/false",
                                    ),
                                    onChanged: (String value) {
                                      NewTabs.status = value.toLowerCase() == 'true';
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  FirebaseFirestore.instance
                                      .collection("Matches")
                                      .doc(widget.selector)
                                      .get()
                                      .then((DocumentSnapshot value) async {
                                    await updateliveColor();
                                    Navigator.pop(context);
                                  });
                                },
                                child: const Text("Update Status")),
                          ],
                        );
                      });
                },
                  ),
              IconButton(
                icon: const Icon(Icons.message),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Add message"),
                          content: SizedBox(
                            height: 150.0,
                            child: Column(
                              children: [
                                Expanded(
                                  child: TextField(
                                    decoration: const InputDecoration(
                                      hintText: "write message",
                                    ),
                                    onChanged: (String value) {
                                      result = value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  FirebaseFirestore.instance
                                      .collection("Matches")
                                      .doc(widget.selector)
                                      .get()
                                      .then((DocumentSnapshot value) async {
                                    await updateMessage();
                                    Navigator.pop(context);
                                  });
                                },
                                child: const Text("Update message")),
                          ],
                        );
                      });
                },
              ),
            ],
          ),
          body: TabBarView(children: [
            //Squads tab1
            Squads(
                selector: widget.selector,
                team1: widget.team1,
                team2: widget.team2),
            //Ing1 tab2
            SingleChildScrollView(
              child: BowlingTab(
                selector: widget.selector,
              ),
            ),
            //Ing2 tab3
            Bowling1Tab(
              selector: widget.selector,
            )
          ]),
        ));
  }
}

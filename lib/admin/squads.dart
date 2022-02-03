import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Squads extends StatefulWidget {
  const Squads(
      {Key? key,
      required this.selector,
      required this.team1,
      required this.team2})
      : super(key: key);

  final String selector;
  final String team1;
  final String team2;
  @override
  _SquadsState createState() => _SquadsState();
}

class _SquadsState extends State<Squads> {
  String playerName = '';

  showBoxforteam1() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add Player"),
            content: SizedBox(
              height: 96.0,
              child: Column(children: [
                TextField(
                  decoration: const InputDecoration(
                    hintText: "player name",
                  ),
                  onChanged: (String value) {
                    playerName = value;
                  },
                ),
              ]),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    addPlayerForTeam1(playerName);
                    Navigator.pop(context);
                  },
                  child: const Text("add")),
            ],
          );
        });
  }

  showforDelteam1() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete Player"),
            content: SizedBox(
              height: 96.0,
              child: Column(children: [
                TextField(
                  decoration: const InputDecoration(
                    hintText: "player name",
                  ),
                  onChanged: (String value) {
                    playerName = value;
                  },
                ),
              ]),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    deletePlayerForTeam1(playerName);
                    Navigator.pop(context);
                  },
                  child: const Text("Delete")),
            ],
          );
        });
  }

    showforDelteam2() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Delete Player"),
            content: SizedBox(
              height: 96.0,
              child: Column(children: [
                TextField(
                  decoration: const InputDecoration(
                    hintText: "player name",
                  ),
                  onChanged: (String value) {
                    playerName = value;
                  },
                ),
              ]),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    deletePlayerForTeam2(playerName);
                    Navigator.pop(context);
                  },
                  child: const Text("Delete")),
            ],
          );
        });
  }

  //box2
  showBoxforteam2() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Add Player"),
            content: SizedBox(
              height: 96.0,
              child: Column(children: [
                TextField(
                  decoration: const InputDecoration(
                    hintText: "player name",
                  ),
                  onChanged: (String value) {
                    playerName = value;
                  },
                ),
              ]),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    addPlayerForTeam2(playerName);
                    Navigator.pop(context);
                  },
                  child: const Text("add")),
            ],
          );
        });
  }

  addPlayerForTeam1(String playername) {
    var documentReference = FirebaseFirestore.instance
        .collection("Matches")
        .doc(widget.selector)
        .collection("Team1Squad")
        .doc(playername);

    Map<String, dynamic> map1 = {
      "playername": playername,
      "created": FieldValue.serverTimestamp(),
    };
    documentReference.set(map1);
  }

  deletePlayerForTeam1(String playername) {
    var documentReference = FirebaseFirestore.instance
        .collection("Matches")
        .doc(widget.selector)
        .collection("Team1Squad")
        .doc(playername);

        documentReference.delete();
  }

  deletePlayerForTeam2(String playername) {
    var documentReference = FirebaseFirestore.instance
        .collection("Matches")
        .doc(widget.selector)
        .collection("Team2Squad")
        .doc(playername);

        documentReference.delete();
  }

  addPlayerForTeam2(String playername) {
    var documentReference = FirebaseFirestore.instance
        .collection("Matches")
        .doc(widget.selector)
        .collection("Team2Squad")
        .doc(playername);

    Map<String, dynamic> map2 = {
      "playername": playername,
      "created": FieldValue.serverTimestamp()
    };
    documentReference.set(map2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      showBoxforteam1();
                    },
                    child: const Text('Add T1')),
                TextButton(
                    onPressed: () {
                      showBoxforteam2();
                    },
                    child: const Text('Add T2')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      showforDelteam1();
                    },
                    child: const Text('Delete T1')),
                TextButton(
                    onPressed: () {
                      showforDelteam2();
                    },
                    child: const Text('Delete T2')),
              ],
            ),
            const Divider(),
            Text(
              widget.team1,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),

            //streambuilder for team1

            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Matches")
                    .doc(widget.selector)
                    .collection("Team1Squad")
                    .orderBy('created', descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> documentSnapshot =
                              snapshot.data!.docs[index].data();
                          return Card(
                            child: ListTile(
                              leading: const CircleAvatar(
                                radius: 14.0,
                                backgroundImage:
                                    AssetImage("assets/images/iogo.png"),
                              ),
                              title: Text(
                                documentSnapshot["playername"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                            ),
                          );
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            const SizedBox(
              height: 20.0,
            ),
            const Divider(),
            const SizedBox(
              height: 20.0,
            ),

            Text(
              widget.team2,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            //Strembuilder 2
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Matches")
                    .doc(widget.selector)
                    .collection("Team2Squad")
                    .orderBy('created', descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map<String, dynamic> documentSnapshot =
                              snapshot.data!.docs[index].data();
                          return Card(
                            child: ListTile(
                              leading: const CircleAvatar(
                                radius: 14.0,
                                backgroundImage:
                                    AssetImage("assets/images/iogo.png"),
                              ),
                              title: Text(
                                documentSnapshot["playername"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                            ),
                          );
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}

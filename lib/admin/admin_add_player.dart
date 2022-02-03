
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_score_app/admin/Inng1Tab.dart';
// import 'Inng1Tab.dart';


class AddPlayer extends StatefulWidget {
    const AddPlayer({ Key? key, required this.selector }) : super(key: key);
  static int team1Wickets = 0;
  final String selector;
  static String stricker = '';
  static String nonStricker = '';
  @override
  _AddPlayerState createState() => _AddPlayerState();
}

class _AddPlayerState extends State<AddPlayer> {
  int sixes = 0;
  int fours = 0;
  int balls = 0;
  int run = 0;

  String playerName = '';
  bool out = true;
  int localteamscore = 0;

  swapPlayer() {
    String temp = AddPlayer.stricker;
    AddPlayer.stricker = AddPlayer.nonStricker;
    AddPlayer.nonStricker = temp;
  }

  createPlayerData(String playername) {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("Matches")
        .doc(widget.selector)
        .collection("Players")
        .doc(playername);

    Map<String, dynamic> player = {
      "Name": playername,
      "Runs": 0,
      "Balls": 0,
      "status": true,
      "six": 0,
      "four": 0,
      "created": FieldValue.serverTimestamp()
    };
    documentReference.set(player);
  }

  updatePlayerDataFor1() {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("Matches")
        .doc(widget.selector)
        .collection("Players")
        .doc(AddPlayer.stricker);

    Map<String, dynamic> player = {
      "Name": AddPlayer.stricker,
      "Runs": run,
      "Balls": balls,
      "six": sixes,
      "four": fours,
      "status": out
    };
    documentReference.update(player).whenComplete(() => debugPrint("updated"));
  }

  updateTeamScore() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Matches").doc(widget.selector);

    Map<String, dynamic> tscore = {"Team1Score": localteamscore};
    documentReference.update(tscore).whenComplete(() => debugPrint("updated"));
  }

  updateTeam1Wickets() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Matches").doc(widget.selector);

    Map<String, dynamic> twickets = {"Team1Wicket": AddPlayer.team1Wickets};
    documentReference.update(twickets).whenComplete(() => debugPrint("updated"));
  }

  @override
  Widget build(BuildContext context) {
    DocumentReference fetchTeamData =
        FirebaseFirestore.instance.collection("Matches").doc(widget.selector);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue[800],
            title: const Text("Add Player"),
            centerTitle: true,
            bottom: const TabBar(
              tabs: [
                Tab(
                  child: Text('Batting'),
                ),
                Tab(
                  child: Text('Bowling'),
                )
              ],
            ),
            actions: [
              IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
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
                                    hintText: "Stricker",
                                  ),
                                  onChanged: (String value) {
                                    AddPlayer.stricker = value;
                                  },
                                ),
                                TextField(
                                  decoration: const InputDecoration(
                                    hintText: "Non Stricker",
                                  ),
                                  onChanged: (String value) {
                                    AddPlayer.nonStricker = value;
                                  },
                                ),
                              ]),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    playerName = AddPlayer.stricker;
                                    createPlayerData(playerName);
                                  },
                                  child: const Text("sticker")),
                              TextButton(
                                  onPressed: () {
                                    playerName = AddPlayer.nonStricker;
                                    createPlayerData(playerName);
                                    Navigator.pop(context);
                                  },
                                  child: const Text(" non sticker"))
                            ],
                          );
                        });
                  })
            ],
          ),
          body: TabBarView(children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  //container for score
                  Container(
                    height: 200.0,
                    // width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const[
                            Text("Batsman"),
                            Text("Runs"),
                            Text("Balls"),
                            Text("6"),
                            Text("4")
                          ],
                        ),
                        //stream builder
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .collection("Players")
                                .orderBy('created', descending: false)
                                .snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (BuildContext context,int  index) {
                                      Map<String, dynamic> documentSnapshot =
                                          snapshot.data!.docs[index].data();
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 10.0),
                                        child: Card(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 4,
                                                child: Text(
                                                  documentSnapshot["Name"] ==
                                                          AddPlayer.stricker
                                                      ? documentSnapshot[
                                                              "Name"] +
                                                          "*"
                                                      : documentSnapshot[
                                                              "Name"] +
                                                          " ",
                                                  style: TextStyle(
                                                      color: documentSnapshot[
                                                                  "status"] ==
                                                              true
                                                          ? Colors.green
                                                          : Colors.black,
                                                      fontSize: 20.0),
                                                ),
                                              ),
                                              // SizedBox(width: 50.0),
                                              Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                      documentSnapshot["Runs"]
                                                          .toString())),
                                              // SizedBox(width: 40.0),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                    documentSnapshot["Balls"]
                                                        .toString()),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                    documentSnapshot["six"]
                                                        .toString()),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                    documentSnapshot["four"]
                                                        .toString()),
                                              ),
                                            ],
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
                  const SizedBox(
                    height: 50.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                            child: Column(
                              children: [
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        swapPlayer();
                                      });
                                    },
                                    child: const Text("Swap Batsman")),
                                TextButton(
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection("Matches")
                                          .doc(widget.selector)
                                          .get()
                                          .then((DocumentSnapshot value) async {
                                        AddPlayer.team1Wickets =
                                            value["Team1Wicket"];
                                        AddPlayer.team1Wickets++;
                                        await updateTeam1Wickets();
                                      });
                                      FirebaseFirestore.instance
                                          .collection("Matches")
                                          .doc(widget.selector)
                                          .collection("Players")
                                          .doc(AddPlayer.stricker)
                                          .get()
                                          .then((DocumentSnapshot value) async {
                                        out = value["status"];
                                        out = false;
                                        balls = value["Balls"];
                                        balls++;
                                        run = value["Runs"];
                                        fours = value["four"];
                                        sixes = value["six"];

                                        await updatePlayerDataFor1();
                                        balls = 0;
                                        run = 0;
                                        fours = 0;
                                        sixes = 0;
                                        out = true;
                                      });
                                      //
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text("Add Player"),
                                              content: Container(
                                                child: TextField(
                                                  decoration: const InputDecoration(
                                                    hintText: "Stricker",
                                                  ),
                                                  onChanged: (String value) {
                                                    AddPlayer.stricker = value;
                                                  },
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      playerName =
                                                          AddPlayer.stricker;
                                                      createPlayerData(
                                                          playerName);
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("sticker")),
                                              ],
                                            );
                                          });
                                    },
                                    child: const Text("Out")),
                                TextButton(
                                  onPressed: () {
                                    fetchTeamData
                                        .get()
                                        .then((DocumentSnapshot value) async {
                                      localteamscore =
                                          value["Team1Score"];
                                      localteamscore++;
                                      await updateTeamScore();
                                      // await getTeamScore();
                                    });
                                  },
                                  child: const Text("Wide"),
                                )
                              ],
                            ),
                          )),
                      Expanded(
                          child: Container(
                              child: Column(
                        children: [
                          Row(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection("Matches")
                                        .doc(widget.selector)
                                        .collection("Players")
                                        .doc(AddPlayer.stricker)
                                        .get()
                                        .then((DocumentSnapshot value) async {
                                      balls = value["Balls"];
                                      balls++;
                                      debugPrint(balls.toString());
                                      run = value["Runs"];
                                      fours = value["four"];
                                      sixes = value["six"];
                                      await updatePlayerDataFor1();
                                      balls = 0;
                                      run = 0;
                                      fours = 0;
                                      sixes = 0;
                                    });
                                  },
                                  child: const Text("0")),
                              TextButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection("Matches")
                                        .doc(widget.selector)
                                        .collection("Players")
                                        .doc(AddPlayer.stricker)
                                        .get()
                                        .then((DocumentSnapshot value) async {
                                      run = value["Runs"];
                                      run++;
                                      balls = value["Balls"];
                                      balls++;
                                      fours = value["four"];
                                      sixes = value["six"];
                                      await updatePlayerDataFor1();
                                      run = 0;
                                      balls = 0;
                                      fours = 0;
                                      sixes = 0;
                                      swapPlayer();
                                      fetchTeamData
                                          .get()
                                          .then((DocumentSnapshot value) async {
                                        localteamscore =
                                            value["Team1Score"];
                                        localteamscore++;
                                        debugPrint(localteamscore.toString());
                                        await updateTeamScore();
                                      });
                                    });
                                  },
                                  child: const Text("1")),
                            ],
                          ),
                          Row(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection("Matches")
                                        .doc(widget.selector)
                                        .collection("Players")
                                        .doc(AddPlayer.stricker)
                                        .get()
                                        .then((DocumentSnapshot value) async {
                                      balls = value["Balls"];
                                      balls++;
                                      debugPrint(balls.toString());
                                      run = value["Runs"];
                                      run += 2;
                                      fours = value["four"];
                                      sixes = value["six"];
                                      await updatePlayerDataFor1();
                                      balls = 0;
                                      run = 0;
                                      fours = 0;
                                      sixes = 0;
                                    });
                                    fetchTeamData
                                        .get()
                                        .then((DocumentSnapshot value) async {
                                      localteamscore =
                                          value["Team1Score"];
                                      localteamscore += 2;
                                      updateTeamScore();
                                    });
                                  },
                                  child: const Text("2")),
                              TextButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection("Matches")
                                        .doc(widget.selector)
                                        .collection("Players")
                                        .doc(AddPlayer.stricker)
                                        .get()
                                        .then((DocumentSnapshot value) async {
                                      run = value["Runs"];
                                      run += 3;
                                      balls = value["Balls"];
                                      balls++;
                                      debugPrint(run.toString());
                                      debugPrint(balls.toString());
                                      fours = value["four"];
                                      sixes = value["six"];
                                      await updatePlayerDataFor1();
                                      run = 0;
                                      balls = 0;
                                      fours = 0;
                                      sixes = 0;
                                      swapPlayer();
                                      fetchTeamData
                                          .get()
                                          .then((DocumentSnapshot value) async {
                                        localteamscore =
                                            value["Team1Score"];
                                        localteamscore += 3;
                                        await updateTeamScore();
                                      });
                                    });
                                  },
                                  child: const Text("3")),
                            ],
                          ),
                          Row(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection("Matches")
                                        .doc(widget.selector)
                                        .collection("Players")
                                        .doc(AddPlayer.stricker)
                                        .get()
                                        .then((DocumentSnapshot value) async {
                                      balls = value["Balls"];
                                      balls++;
                                      debugPrint(balls.toString());
                                      run = value["Runs"];
                                      run += 4;
                                      fours = value["four"];
                                      fours++;
                                      sixes = value["six"];
                                      await updatePlayerDataFor1();
                                      balls = 0;
                                      run = 0;
                                      sixes = 0;
                                      fours = 0;
                                    });
                                    fetchTeamData
                                        .get()
                                        .then((DocumentSnapshot value) async {
                                      localteamscore =
                                          value["Team1Score"];
                                      localteamscore += 4;
                                      await updateTeamScore();
                                    });
                                  },
                                  child: const Text("4")),
                              TextButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection("Matches")
                                        .doc(widget.selector)
                                        .collection("Players")
                                        .doc(AddPlayer.stricker)
                                        .get()
                                        .then((DocumentSnapshot value) async {
                                      run = value["Runs"];
                                      run += 5;
                                      balls = value["Balls"];
                                      balls++;
                                      debugPrint(run.toString());
                                      debugPrint(balls.toString());
                                      fours = value["four"];
                                      sixes = value["six"];
                                      await updatePlayerDataFor1();
                                      run = 0;
                                      balls = 0;
                                      fours = 0;
                                      sixes = 0;
                                      swapPlayer();
                                      fetchTeamData
                                          .get()
                                          .then((DocumentSnapshot value) async {
                                        localteamscore =
                                            value["Team1Score"];
                                        localteamscore += 5;
                                        await updateTeamScore();
                                      });
                                    });
                                  },
                                  child: const Text("5")),
                            ],
                          ),
                          Row(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection("Matches")
                                        .doc(widget.selector)
                                        .collection("Players")
                                        .doc(AddPlayer.stricker)
                                        .get()
                                        .then((DocumentSnapshot value) async {
                                      balls = value["Balls"];
                                      balls++;
                                      debugPrint(balls.toString());
                                      run = value["Runs"];
                                      run += 6;
                                      sixes = value["six"];
                                      sixes++;
                                      fours = value["four"];
                                      await updatePlayerDataFor1();
                                      balls = 0;
                                      run = 0;
                                      sixes = 0;
                                      fours = 0;
                                    });
                                    fetchTeamData
                                        .get()
                                        .then((DocumentSnapshot value) async {
                                      localteamscore =
                                          value["Team1Score"];
                                      localteamscore += 6;
                                      await updateTeamScore();
                                    });
                                  },
                                  child: const Text("6")),
                              //FlatButton(onPressed: () {}, child: Text(".")),
                            ],
                          ),
                        ],
                      )))
                    ],
                  ),
                  Text("Team Score:$localteamscore")
                ],
              ),
            ),

            //second tab i.e bowling tab
            SingleChildScrollView(
              child: BowlingTab(
                selector: widget.selector,
              ),
            )
          ])),
    );
  }
}

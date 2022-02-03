// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BowlingTab extends StatefulWidget {
  const BowlingTab({Key? key, required this.selector}) : super(key: key);
  final String selector;
  static String bowlername = '';
  static String stricker = '';
  static String nonStricker = '';
  static int team1Wickets = 0;
  static String strikeBowler = '';
  static int totalOver1 = 0;
  static int totalballs1 = 0;
  static List<String> overballs = [];
  @override
  _BowlingTabState createState() => _BowlingTabState();
}

class _BowlingTabState extends State<BowlingTab> {
  bool out = true;
  bool status = true;
  int over = 0;
  int runs = 0;
  int wicket = 0;
  int balls = 0;
  String batsmanName = '';
  int sixes = 0;
  int fours = 0;
  int ball = 0;
  int run = 0;
  int localteamscore = 0;

  swapPlayer() {
    String temp = BowlingTab.stricker;
    BowlingTab.stricker = BowlingTab.nonStricker;
    BowlingTab.nonStricker = temp;
  }

  showmyDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("select bowler"),
            content: SizedBox(
              height: 96.0,
              child: Column(children: [
                TextField(
                  decoration: const InputDecoration(
                    hintText: "bowler name",
                  ),
                  onChanged: (String value) {
                    BowlingTab.strikeBowler = value;
                  },
                ),
              ]),
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    BowlingTab.bowlername = BowlingTab.strikeBowler;
                    FirebaseFirestore.instance
                        .collection("Matches")
                        .doc(widget.selector)
                        .collection("Inng1Bowler")
                        .doc(BowlingTab.bowlername)
                        .get()
                        .then((DocumentSnapshot value) async {
                      createBowler(BowlingTab.bowlername);
                    });

                    Navigator.pop(context);
                  },
                  child: const Text("add")),
              TextButton(
                  onPressed: () async {
                    BowlingTab.bowlername = BowlingTab.strikeBowler;
                    FirebaseFirestore.instance
                        .collection("Matches")
                        .doc(widget.selector)
                        .collection("Inng1Bowler")
                        .doc(BowlingTab.bowlername)
                        .get()
                        .then((value) async {
                      over = value["Over"];
                      runs = value['Runs'];
                      wicket = value["Wicket"];
                      status = value["status"];
                      status = true;
                      await updateBowler(BowlingTab.bowlername);
                    });

                    Navigator.pop(context);
                  },
                  child: const Text("select")),
            ],
          );
        });
  }

  createBowler(String bowler) {
    var documentReference = FirebaseFirestore.instance
        .collection("Matches")
        .doc(widget.selector)
        .collection("Inng1Bowler")
        .doc(bowler);

    Map<String, dynamic> bowlerdata = {
      "Name": bowler,
      "Over": 0,
      "Runs": 0,
      "Balls": 0,
      "Wicket": 0,
      "status": true
    };
    documentReference.set(bowlerdata);
  }

  updateBowler(bowler) {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("Matches")
        .doc(widget.selector)
        .collection("Inng1Bowler")
        .doc(bowler);

    Map<String, dynamic> bowlerdata = {
      "Name": bowler,
      "Over": over,
      "Runs": runs,
      "Balls": balls,
      "Wicket": wicket,
      "status": status
    };
    documentReference.update(bowlerdata);
  }

  // updateTeam2Score(team2score, team2wicket) {
  //   DocumentReference documentReference =
  //       FirebaseFirestore.instance.collection("Matches").doc(widget.selector);

  //   Map<String, dynamic> team2data = {
  //     "Team2Score": team2score,
  //     "Team2Wicket": team2wicket
  //   };
  //   documentReference.update(team2data);
  // }

  createBatsmanData(String playername) {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("Matches")
        .doc(widget.selector)
        .collection("Inng1Batsman")
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

  updateTeam1Wickets() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Matches").doc(widget.selector);

    Map<String, dynamic> twickets = {"Team1Wicket": BowlingTab.team1Wickets};
    documentReference
        .update(twickets)
        .whenComplete(() => debugprint("updated"));
  }

  updatePlayerDataFor1() {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("Matches")
        .doc(widget.selector)
        .collection("Inng1Batsman")
        .doc(BowlingTab.stricker);

    Map<String, dynamic> player = {
      "Name": BowlingTab.stricker,
      "Runs": run,
      "Balls": ball,
      "six": sixes,
      "four": fours,
      "status": out
    };
    documentReference.update(player).whenComplete(() => debugprint("updated"));
  }

  updateTeamScore() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Matches").doc(widget.selector);

    Map<String, dynamic> tscore = {"Team1Score": localteamscore};
    documentReference.update(tscore).whenComplete(() => debugprint("updated"));
  }

  updateTotalOver1() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Matches").doc(widget.selector);

    Map<String, dynamic> totalOver1 = {"TotalOver1": BowlingTab.totalOver1};

    documentReference.update(totalOver1);
  }

  updateTotalBalls1() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Matches").doc(widget.selector);

    Map<String, dynamic> totalball1 = {"TotalBalls1": BowlingTab.totalballs1};

    documentReference.update(totalball1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {
                    //dialog box

                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Add bowler"),
                            content: SizedBox(
                              height: 96.0,
                              child: Column(children: [
                                TextField(
                                  decoration: const InputDecoration(
                                    hintText: "bowler name",
                                  ),
                                  onChanged: (String value) {
                                    BowlingTab.strikeBowler = value;
                                  },
                                ),
                              ]),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    BowlingTab.bowlername =
                                        BowlingTab.strikeBowler;
                                    createBowler(BowlingTab.bowlername);
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Add")),
                            ],
                          );
                        });
                  },
                  child: const Text('Addbowler')),

              //add batsman
              TextButton(
                  child: const Text("Add Batsman"),
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
                                    BowlingTab.stricker = value;
                                  },
                                ),
                                TextField(
                                  decoration: const InputDecoration(
                                    hintText: "Non Stricker",
                                  ),
                                  onChanged: (String value) {
                                    BowlingTab.nonStricker = value;
                                  },
                                ),
                              ]),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    batsmanName = BowlingTab.stricker;
                                    createBatsmanData(batsmanName);
                                  },
                                  child: const Text("stricker")),
                              TextButton(
                                  onPressed: () {
                                    batsmanName = BowlingTab.nonStricker;
                                    createBatsmanData(batsmanName);
                                    Navigator.pop(context);
                                  },
                                  child: const Text(" non sticker"))
                            ],
                          );
                        });
                  }),

              //Streambuilder

              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Matches")
                      .doc(widget.selector)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      var team2score = snapshot.data;
                      var team2wicket = snapshot.data;
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                team2score["Team1Score"].toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22.0),
                              ),
                              const Text(
                                '/',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22.0),
                              ),
                              Text(
                                team2wicket["Team1Wicket"].toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22.0),
                              )
                            ],
                          ),
                          Row(
                            children: const [
                              Text(
                                "Score",
                                style: TextStyle(
                                     fontSize: 10.0),
                              ),
                              Text(
                                '/',
                                style: TextStyle(
                                   fontSize: 10.0),
                              ),
                              Text(
                                "Wicket",
                                style: TextStyle(
                                     fontSize: 10.0),
                              )
                            ],
                          ),
                        ],
                      );
                    } else {
                      return const Text("0");
                    }
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () {
                    //dialog box
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Update Score and Wickets"),
                            content: SizedBox(
                              height: 96.0,
                              child: Column(children: [
                                TextField(
                                  decoration: const InputDecoration(
                                    hintText: "Current Score",
                                  ),
                                  onChanged: (String value) {
                                    localteamscore = int.parse(value);
                                  },
                                ),
                                TextField(
                                  decoration: const InputDecoration(
                                    hintText: "Current Wickets",
                                  ),
                                  onChanged: (String value) {
                                    BowlingTab.team1Wickets = int.parse(value);
                                  },
                                ),
                              ]),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    updateTeamScore();
                                    updateTeam1Wickets();
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Update")),
                            ],
                          );
                        });
                  },
                  child: const Text('Update Score_wick')),
              TextButton(
                  onPressed: () {
                    //dialog box
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Update Overs and Balls"),
                            content: SizedBox(
                              height: 96.0,
                              child: Column(children: [
                                TextField(
                                  decoration: const InputDecoration(
                                    hintText: "Current Over",
                                  ),
                                  onChanged: (String value) {
                                    BowlingTab.totalOver1 = int.parse(value);
                                  },
                                ),
                                TextField(
                                  decoration: const InputDecoration(
                                    hintText: "Current Balls",
                                  ),
                                  onChanged: (String value) {
                                    BowlingTab.totalballs1 = int.parse(value);
                                  },
                                ),
                              ]),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    updateTotalOver1();
                                    updateTotalBalls1();
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Update")),
                            ],
                          );
                        });
                  },
                  child: const Text('Update Overs_balls')),

              //Streambuilder

              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Matches")
                      .doc(widget.selector)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      var team2score = snapshot.data;
                      var team2wicket = snapshot.data;
                      return Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                team2score["TotalOver1"].toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22.0),
                              ),
                              const Text(
                                '/',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22.0),
                              ),
                              Text(
                                team2wicket["TotalBalls1"].toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22.0),
                              )
                            ],
                          ),
                          Row(
                            children: const [
                              Text(
                                "Overs",
                                style: TextStyle(
                                     fontSize: 10.0),
                              ),
                              Text(
                                '/',
                                style: TextStyle(
                                   fontSize: 10.0),
                              ),
                              Text(
                                "Balls",
                                style: TextStyle(
                                     fontSize: 10.0),
                              )
                            ],
                          ),
                        ],
                      );
                    } else {
                      return const Text("0");
                    }
                  }),
            ],
          ),

          //Batsman Container
          Container(
            // constraints: BoxConstraints(minHeight: 30.0, maxHeight: 500),
            //height: 500,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text(
                          'Batsman',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(),
                        Text(
                          'Runs',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Balls',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '4s',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '6s',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),

                //stream builder for batsman
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Matches")
                        .doc(widget.selector)
                        .collection("Inng1Batsman")
                        .orderBy('created', descending: false)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
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
                                                  BowlingTab.stricker
                                              ? documentSnapshot["Name"] + "*"
                                              : documentSnapshot["Name"] + " ",
                                          style: TextStyle(
                                              color:
                                                  documentSnapshot["status"] ==
                                                          true
                                                      ? Colors.blue[400]
                                                      : Colors.grey[600],
                                              fontSize: 17.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      // SizedBox(width: 50.0),
                                      Expanded(
                                          flex: 2,
                                          child: Text(documentSnapshot["Runs"]
                                              .toString())),
                                      // SizedBox(width: 40.0),
                                      Expanded(
                                        flex: 2,
                                        child: Text(documentSnapshot["Balls"]
                                            .toString()),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(documentSnapshot["four"]
                                            .toString()),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                            documentSnapshot["six"].toString()),
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
          //bottom conatiner for batsman button
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            swapPlayer();
                          });
                        },
                        child: const Text('SwapBatsman'),
                      ),
                      TextButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("Matches")
                              .doc(widget.selector)
                              .collection("Inng1Batsman")
                              .doc(BowlingTab.stricker)
                              .get()
                              .then((DocumentSnapshot value) async {
                            ball = value["Balls"];
                            ball++;
                            print(balls);
                            run = value["Runs"];
                            fours = value["four"];
                            sixes = value["six"];
                            await updatePlayerDataFor1();
                            ball = 0;
                            run = 0;
                            fours = 0;
                            sixes = 0;
                          });
                        },
                        child: const Text('0'),
                      ),
                      TextButton(
                        onPressed: () {
                          batsmanName = BowlingTab.stricker;
                          FirebaseFirestore.instance
                              .collection("Matches")
                              .doc(widget.selector)
                              .collection("Inng1Batsman")
                              .doc(BowlingTab.stricker)
                              .get()
                              .then((DocumentSnapshot value) async {
                            run = value["Runs"];
                            run++;
                            ball = value["Balls"];
                            ball++;
                            fours = value["four"];
                            sixes = value["six"];
                            await updatePlayerDataFor1();
                            run = 0;
                            ball = 0;
                            fours = 0;
                            sixes = 0;
                            swapPlayer();
                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .get()
                                .then((DocumentSnapshot value) async {
                              localteamscore = value["Team1Score"];
                              localteamscore++;
                              print(localteamscore);
                              await updateTeamScore();
                            });
                          });
                        },
                        child: const Text('1'),
                      ),
                      TextButton(
                        onPressed: () {
                          batsmanName = BowlingTab.stricker;
                          FirebaseFirestore.instance
                              .collection("Matches")
                              .doc(widget.selector)
                              .collection("Inng1Batsman")
                              .doc(BowlingTab.stricker)
                              .get()
                              .then((DocumentSnapshot value) async {
                            ball = value["Balls"];
                            ball++;
                            print(balls);
                            run = value["Runs"];
                            run += 2;
                            fours = value["four"];
                            sixes = value["six"];
                            await updatePlayerDataFor1();
                            ball = 0;
                            run = 0;
                            fours = 0;
                            sixes = 0;
                          });
                          FirebaseFirestore.instance
                              .collection("Matches")
                              .doc(widget.selector)
                              .get()
                              .then((DocumentSnapshot value) async {
                            localteamscore = value["Team1Score"];
                            localteamscore += 2;
                            updateTeamScore();
                          });
                        },
                        child: const Text('2'),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection("Matches")
                              .doc(widget.selector)
                              .get()
                              .then((DocumentSnapshot value) async {
                            BowlingTab.team1Wickets = value["Team1Wicket"];
                          });
                          FirebaseFirestore.instance
                              .collection("Matches")
                              .doc(widget.selector)
                              .collection("Inng1Batsman")
                              .doc(BowlingTab.stricker)
                              .get()
                              .then((DocumentSnapshot value) async {
                            out = value["status"];
                            out = false;
                            ball = value["Balls"];
                            ball++;
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
                                        BowlingTab.stricker = value;
                                      },
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          batsmanName = BowlingTab.stricker;
                                          createBatsmanData(batsmanName);
                                          Navigator.pop(context);
                                        },
                                        child: const Text("sticker")),
                                  ],
                                );
                              });
                        },
                        child: const Text('out'),
                      ),
                      TextButton(
                        onPressed: () {
                          batsmanName = BowlingTab.stricker;
                          FirebaseFirestore.instance
                              .collection("Matches")
                              .doc(widget.selector)
                              .collection("Inng1Batsman")
                              .doc(BowlingTab.stricker)
                              .get()
                              .then((DocumentSnapshot value) async {
                            run = value["Runs"];
                            run += 3;
                            ball = value["Balls"];
                            ball++;

                            fours = value["four"];
                            sixes = value["six"];
                            await updatePlayerDataFor1();
                            run = 0;
                            ball = 0;
                            fours = 0;
                            sixes = 0;
                            swapPlayer();
                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .get()
                                .then((DocumentSnapshot value) async {
                              localteamscore = value["Team1Score"];
                              localteamscore += 3;
                              await updateTeamScore();
                            });
                          });
                        },
                        child: const Text('3'),
                      ),
                      TextButton(
                        onPressed: () {
                          batsmanName = BowlingTab.stricker;
                          FirebaseFirestore.instance
                              .collection("Matches")
                              .doc(widget.selector)
                              .collection("Inng1Batsman")
                              .doc(BowlingTab.stricker)
                              .get()
                              .then((DocumentSnapshot value) async {
                            run = value["Runs"];
                            run += 4;
                            ball = value["Balls"];
                            ball++;

                            fours = value["four"];
                            fours++;
                            sixes = value["six"];
                            await updatePlayerDataFor1();
                            run = 0;
                            ball = 0;
                            fours = 0;
                            sixes = 0;

                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .get()
                                .then((DocumentSnapshot value) async {
                              localteamscore = value["Team1Score"];
                              localteamscore += 4;
                              await updateTeamScore();
                            });
                          });
                        },
                        child: const Text('4'),
                      ),
                      TextButton(
                        onPressed: () {
                          batsmanName = BowlingTab.stricker;
                          FirebaseFirestore.instance
                              .collection("Matches")
                              .doc(widget.selector)
                              .collection("Inng1Batsman")
                              .doc(BowlingTab.stricker)
                              .get()
                              .then((DocumentSnapshot value) async {
                            run = value["Runs"];
                            run += 4;
                            ball = value["Balls"];

                            fours = value["four"];
                            fours++;
                            sixes = value["six"];
                            await updatePlayerDataFor1();
                            run = 0;
                            ball = 0;
                            fours = 0;
                            sixes = 0;

                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .get()
                                .then((DocumentSnapshot value) async {
                              localteamscore = value["Team1Score"];
                              localteamscore += 5;
                              await updateTeamScore();
                            });
                          });
                        },
                        child: const Text('nb 4'),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          BowlingTab.bowlername = BowlingTab.strikeBowler;
                          FirebaseFirestore.instance
                              .collection("Matches")
                              .doc(widget.selector)
                              .get()
                              .then((DocumentSnapshot value) async {
                            localteamscore = value["Team1Score"];
                            localteamscore++;
                            await updateTeamScore();
                          });
                        },
                        child: const Text('wide'),
                      ),
                      TextButton(
                        onPressed: () {
                          batsmanName = BowlingTab.stricker;
                          FirebaseFirestore.instance
                              .collection("Matches")
                              .doc(widget.selector)
                              .collection("Inng1Batsman")
                              .doc(BowlingTab.stricker)
                              .get()
                              .then((DocumentSnapshot value) async {
                            run = value["Runs"];
                            run += 6;
                            ball = value["Balls"];
                            ball++;

                            fours = value["four"];
                            sixes = value["six"];
                            sixes++;
                            await updatePlayerDataFor1();
                            run = 0;
                            ball = 0;
                            fours = 0;
                            sixes = 0;

                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .get()
                                .then((DocumentSnapshot value) async {
                              localteamscore = value["Team1Score"];
                              localteamscore += 6;
                              await updateTeamScore();
                            });
                          });
                        },
                        child: const Text('6'),
                      ),
                      TextButton(
                        onPressed: () {
                          batsmanName = BowlingTab.stricker;
                          FirebaseFirestore.instance
                              .collection("Matches")
                              .doc(widget.selector)
                              .collection("Inng1Batsman")
                              .doc(BowlingTab.stricker)
                              .get()
                              .then((DocumentSnapshot value) async {
                            run = value["Runs"];
                            run += 6;
                            ball = value["Balls"];

                            fours = value["four"];
                            sixes = value["six"];
                            sixes++;
                            await updatePlayerDataFor1();
                            run = 0;
                            ball = 0;
                            fours = 0;
                            sixes = 0;

                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .get()
                                .then((DocumentSnapshot value) async {
                              localteamscore = value["Team1Score"];
                              localteamscore += 7;
                              await updateTeamScore();
                            });
                          });
                        },
                        child: const Text('nb 6'),
                      ),
                      TextButton(
                        onPressed: () {
                          batsmanName = BowlingTab.stricker;
                          FirebaseFirestore.instance
                              .collection("Matches")
                              .doc(widget.selector)
                              .collection("Inng1Batsman")
                              .doc(BowlingTab.stricker)
                              .get()
                              .then((DocumentSnapshot value) async {
                            run = value["Runs"];

                            ball = value["Balls"];

                            fours = value["four"];
                            sixes = value["six"];
                            await updatePlayerDataFor1();
                            run = 0;
                            ball = 0;
                            fours = 0;
                            sixes = 0;

                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .get()
                                .then((DocumentSnapshot value) async {
                              localteamscore = value["Team1Score"];
                              localteamscore += 5;
                              await updateTeamScore();
                            });
                          });
                        },
                        child: const Text('wd 5'),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      batsmanName = BowlingTab.stricker;
                      FirebaseFirestore.instance
                          .collection("Matches")
                          .doc(widget.selector)
                          .collection("Inng1Batsman")
                          .doc(BowlingTab.stricker)
                          .get()
                          .then((DocumentSnapshot value) async {
                        run = value["Runs"];

                        ball = value["Balls"];

                        fours = value["four"];
                        sixes = value["six"];
                        await updatePlayerDataFor1();
                        run = 0;
                        ball = 0;
                        fours = 0;
                        sixes = 0;
                        swapPlayer();
                        FirebaseFirestore.instance
                            .collection("Matches")
                            .doc(widget.selector)
                            .get()
                            .then((DocumentSnapshot value) async {
                          localteamscore = value["Team1Score"];
                          localteamscore++;

                          await updateTeamScore();
                        });
                      });
                    },
                    child: const Text('No ball'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          //Bowler Container
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text(
                          'Bowler',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(),
                        Text(
                          'Over',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Runs',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Wicket',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),

                //stream builder
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Matches")
                        .doc(widget.selector)
                        .collection("Inng1Bowler")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            physics: const ScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
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
                                                  BowlingTab.strikeBowler
                                              ? documentSnapshot["Name"] + "*"
                                              : documentSnapshot["Name"] + " ",
                                          style: TextStyle(
                                              color:
                                                  documentSnapshot["status"] ==
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
                                              '${documentSnapshot["Over"]}.${documentSnapshot["Balls"]}'
                                                  .toString())),
                                      // SizedBox(width: 40.0),
                                      Expanded(
                                        flex: 2,
                                        child: Text(documentSnapshot["Runs"]
                                            .toString()),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(documentSnapshot["Wicket"]
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

          //Button container for bowler
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Container(
              height: 150.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text('SwapBowler'),
                      ),
                      TextButton(
                        onPressed: () {
                          BowlingTab.bowlername = BowlingTab.strikeBowler;
                          FirebaseFirestore.instance
                              .collection("Matches")
                              .doc(widget.selector)
                              .collection("Inng1Bowler")
                              .doc(BowlingTab.bowlername)
                              .get()
                              .then((DocumentSnapshot value) async {
                            balls = value["Balls"];
                            if (balls < 6) {
                              balls++;
                              await updateBowler(BowlingTab.bowlername);

                              //totalballs update
                              FirebaseFirestore.instance
                                  .collection("Matches")
                                  .doc(widget.selector)
                                  .get()
                                  .then((DocumentSnapshot value) async {
                                BowlingTab.totalballs1 = value["TotalBalls1"];
                                BowlingTab.totalballs1++;
                                await updateTotalBalls1();
                              });
                              balls = 0;
                              BowlingTab.totalballs1 = 0;
                              setState(() {
                                BowlingTab.overballs.add("0");
                              });
                            } else {
                              over = value["Over"];
                              over++;
                              balls = value["Balls"];
                              balls = 0;
                              status = value["status"];
                              status = false;
                              await updateBowler(BowlingTab.bowlername);
                              //total update
                              FirebaseFirestore.instance
                                  .collection("Matches")
                                  .doc(widget.selector)
                                  .get()
                                  .then((DocumentSnapshot value) async {
                                BowlingTab.totalOver1 = value["TotalOver1"];
                                BowlingTab.totalOver1++;
                                await updateTotalOver1();
                                BowlingTab.totalballs1 = value["TotalBalls1"];
                                BowlingTab.totalballs1 = 0;
                                await updateTotalBalls1();

                                setState(() {
                                  BowlingTab.overballs.clear();
                                });
                              });

                              over = 0;
                              status = true;
                              showmyDialog();
                            }
                          });
                        },
                        child: const Text('0'),
                      ),
                      TextButton(
                        onPressed: () {
                          BowlingTab.bowlername = BowlingTab.strikeBowler;
                          FirebaseFirestore.instance
                              .collection("Matches")
                              .doc(widget.selector)
                              .collection("Inng1Bowler")
                              .doc(BowlingTab.bowlername)
                              .get()
                              .then((DocumentSnapshot value) async {
                            balls = value["Balls"];
                            if (balls < 6) {
                              balls = value["Balls"];
                              balls++;
                              runs = value["Runs"];
                              runs++;
                              await updateBowler(BowlingTab.bowlername);

                              //totalballs update
                              FirebaseFirestore.instance
                                  .collection("Matches")
                                  .doc(widget.selector)
                                  .get()
                                  .then((DocumentSnapshot value) async {
                                BowlingTab.totalballs1 = value["TotalBalls1"];
                                BowlingTab.totalballs1++;
                                await updateTotalBalls1();
                              });
                              BowlingTab.totalballs1 = 0;
                              setState(() {
                                BowlingTab.overballs.add("1");
                              });
                            } else {
                              balls = value["Balls"];
                              balls = 0;
                              over = value["Over"];
                              over++;
                              status = value['status'];
                              status = false;

                              await updateBowler(BowlingTab.bowlername);

                              //total update
                              FirebaseFirestore.instance
                                  .collection("Matches")
                                  .doc(widget.selector)
                                  .get()
                                  .then((DocumentSnapshot value) async {
                                BowlingTab.totalOver1 = value["TotalOver1"];
                                BowlingTab.totalOver1++;
                                await updateTotalOver1();
                                BowlingTab.totalballs1 = value["TotalBalls1"];
                                BowlingTab.totalballs1 = 0;
                                await updateTotalBalls1();
                                setState(() {
                                  BowlingTab.overballs.clear();
                                });
                              });
                              over = 0;
                              status = true;
                              runs = 0;
                              showmyDialog();
                            }
                          });
                        },
                        child: const Text('1'),
                      ),
                      TextButton(
                        onPressed: () {
                          BowlingTab.bowlername = BowlingTab.strikeBowler;
                          FirebaseFirestore.instance
                              .collection("Matches")
                              .doc(widget.selector)
                              .collection("Inng1Bowler")
                              .doc(BowlingTab.bowlername)
                              .get()
                              .then((DocumentSnapshot value) async {
                            balls = value["Balls"];
                            if (balls < 6) {
                              balls = value["Balls"];
                              balls++;
                              runs = value["Runs"];
                              runs += 2;
                              await updateBowler(BowlingTab.bowlername);

                              //totalballs update
                              FirebaseFirestore.instance
                                  .collection("Matches")
                                  .doc(widget.selector)
                                  .get()
                                  .then((DocumentSnapshot value) async {
                                BowlingTab.totalballs1 = value["TotalBalls1"];
                                BowlingTab.totalballs1++;
                                await updateTotalBalls1();
                              });
                              BowlingTab.totalballs1 = 0;
                              setState(() {
                                BowlingTab.overballs.add("2");
                              });
                            } else {
                              balls = value["Balls"];
                              balls = 0;
                              over = value["Over"];
                              over++;
                              status = value['status'];
                              status = false;

                              await updateBowler(BowlingTab.bowlername);

                              //total update
                              FirebaseFirestore.instance
                                  .collection("Matches")
                                  .doc(widget.selector)
                                  .get()
                                  .then((DocumentSnapshot value) async {
                                BowlingTab.totalOver1 = value["TotalOver1"];
                                BowlingTab.totalOver1++;
                                await updateTotalOver1();
                                BowlingTab.totalballs1 = value["TotalBalls1"];
                                BowlingTab.totalballs1 = 0;
                                await updateTotalBalls1();
                                setState(() {
                                  BowlingTab.overballs.clear();
                                });
                              });
                              over = 0;
                              status = true;
                              runs = 0;

                              showmyDialog();
                            }
                          });
                        },
                        child: const Text('2'),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          BowlingTab.bowlername = BowlingTab.strikeBowler;
                          FirebaseFirestore.instance
                              .collection("Matches")
                              .doc(widget.selector)
                              .collection("Inng1Bowler")
                              .doc(BowlingTab.bowlername)
                              .get()
                              .then((DocumentSnapshot value) async {
                            balls = value["Balls"];
                            if (balls < 6) {
                              balls = value["Balls"];

                              runs = value["Runs"];
                              runs++;
                              await updateBowler(BowlingTab.bowlername);
                            }
                          });
                          setState(() {
                            BowlingTab.overballs.add("wd");
                          });
                        },
                        child: const Text('Wide'),
                      ),
                      TextButton(
                        onPressed: () {
                          BowlingTab.bowlername = BowlingTab.strikeBowler;
                          FirebaseFirestore.instance
                              .collection("Matches")
                              .doc(widget.selector)
                              .collection("Inng1Bowler")
                              .doc(BowlingTab.bowlername)
                              .get()
                              .then((DocumentSnapshot value) async {
                            balls = value["Balls"];
                            if (balls < 6) {
                              balls = value["Balls"];
                              balls++;
                              runs = value["Runs"];
                              runs += 3;
                              await updateBowler(BowlingTab.bowlername);
                              //totalballs update
                              FirebaseFirestore.instance
                                  .collection("Matches")
                                  .doc(widget.selector)
                                  .get()
                                  .then((DocumentSnapshot value) async {
                                BowlingTab.totalballs1 = value["TotalBalls1"];
                                BowlingTab.totalballs1++;
                                await updateTotalBalls1();
                              });
                              BowlingTab.totalballs1 = 0;
                              setState(() {
                                BowlingTab.overballs.add("3");
                              });
                            } else {
                              balls = value["Balls"];
                              balls = 0;
                              over = value["Over"];
                              over++;
                              status = value['status'];
                              status = false;

                              await updateBowler(BowlingTab.bowlername);
                              //total update
                              FirebaseFirestore.instance
                                  .collection("Matches")
                                  .doc(widget.selector)
                                  .get()
                                  .then((DocumentSnapshot value) async {
                                BowlingTab.totalOver1 = value["TotalOver1"];
                                BowlingTab.totalOver1++;
                                await updateTotalOver1();
                                BowlingTab.totalballs1 = value["TotalBalls1"];
                                BowlingTab.totalballs1 = 0;
                                await updateTotalBalls1();
                                setState(() {
                                  BowlingTab.overballs.clear();
                                });
                              });
                              over = 0;
                              status = true;
                              runs = 0;

                              showmyDialog();
                            }
                          });
                        },
                        child: const Text('3'),
                      ),
                      TextButton(
                        onPressed: () {
                          BowlingTab.bowlername = BowlingTab.strikeBowler;
                          FirebaseFirestore.instance
                              .collection("Matches")
                              .doc(widget.selector)
                              .collection("Inng1Bowler")
                              .doc(BowlingTab.bowlername)
                              .get()
                              .then((DocumentSnapshot value) async {
                            balls = value["Balls"];
                            if (balls < 6) {
                              balls = value["Balls"];
                              balls++;
                              runs = value["Runs"];
                              runs += 4;
                              await updateBowler(BowlingTab.bowlername);

                              //totalballs update
                              FirebaseFirestore.instance
                                  .collection("Matches")
                                  .doc(widget.selector)
                                  .get()
                                  .then((DocumentSnapshot value) async {
                                BowlingTab.totalballs1 = value["TotalBalls1"];
                                BowlingTab.totalballs1++;
                                await updateTotalBalls1();
                              });
                              BowlingTab.totalballs1 = 0;
                              setState(() {
                                BowlingTab.overballs.add("4");
                              });
                            } else {
                              balls = value["Balls"];
                              balls = 0;
                              over = value["Over"];
                              over++;
                              status = value['status'];
                              status = false;

                              await updateBowler(BowlingTab.bowlername);
                              //total update
                              FirebaseFirestore.instance
                                  .collection("Matches")
                                  .doc(widget.selector)
                                  .get()
                                  .then((DocumentSnapshot value) async {
                                BowlingTab.totalOver1 = value["TotalOver1"];
                                BowlingTab.totalOver1++;
                                await updateTotalOver1();
                                BowlingTab.totalballs1 = value["TotalBalls1"];
                                BowlingTab.totalballs1 = 0;
                                await updateTotalBalls1();
                                setState(() {
                                  BowlingTab.overballs.clear();
                                });
                              });
                              over = 0;
                              status = true;
                              runs = 0;

                              showmyDialog();
                            }
                          });
                        },
                        child: const Text('4'),
                      ),
                      TextButton(
                        onPressed: () {
                          BowlingTab.bowlername = BowlingTab.strikeBowler;
                          FirebaseFirestore.instance
                              .collection("Matches")
                              .doc(widget.selector)
                              .collection("Inng1Bowler")
                              .doc(BowlingTab.bowlername)
                              .get()
                              .then((DocumentSnapshot value) async {
                            balls = value["Balls"];
                            if (balls < 6) {
                              balls = value["Balls"];

                              runs = value["Runs"];
                              runs += 5;
                              await updateBowler(BowlingTab.bowlername);
                            }
                          });
                          setState(() {
                            BowlingTab.overballs.add("Wd4");
                          });
                        },
                        child: const Text('5'),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          BowlingTab.bowlername = BowlingTab.strikeBowler;
                          FirebaseFirestore.instance
                              .collection("Matches")
                              .doc(widget.selector)
                              .collection("Inng1Bowler")
                              .doc(BowlingTab.bowlername)
                              .get()
                              .then((DocumentSnapshot value) async {
                            balls = value["Balls"];
                            if (balls < 6) {
                              balls = value["Balls"];

                              runs = value["Runs"];
                              runs++;
                              await updateBowler(BowlingTab.bowlername);
                            }
                          });
                          setState(() {
                            BowlingTab.overballs.add("Nb");
                          });
                        },
                        child: const Text('NoBall'),
                      ),
                      TextButton(
                        onPressed: () {
                          BowlingTab.bowlername = BowlingTab.strikeBowler;
                          FirebaseFirestore.instance
                              .collection("Matches")
                              .doc(widget.selector)
                              .collection("Inng1Bowler")
                              .doc(BowlingTab.bowlername)
                              .get()
                              .then((DocumentSnapshot value) async {
                            balls = value["Balls"];
                            if (balls < 6) {
                              balls = value["Balls"];
                              balls++;
                              runs = value["Runs"];
                              wicket = value["Wicket"];
                              wicket++;
                              await updateBowler(BowlingTab.bowlername);

                              //totalballs update
                              FirebaseFirestore.instance
                                  .collection("Matches")
                                  .doc(widget.selector)
                                  .get()
                                  .then((DocumentSnapshot value) async {
                                BowlingTab.totalballs1 = value["TotalBalls1"];
                                BowlingTab.totalballs1++;
                                await updateTotalBalls1();
                              });
                              BowlingTab.totalballs1 = 0;
                              setState(() {
                                BowlingTab.overballs.add("Wkt");
                              });
                            } else {
                              balls = value["Balls"];
                              balls = 0;
                              over = value["Over"];
                              over++;
                              status = value['status'];
                              status = false;

                              await updateBowler(BowlingTab.bowlername);
                              //total update
                              FirebaseFirestore.instance
                                  .collection("Matches")
                                  .doc(widget.selector)
                                  .get()
                                  .then((DocumentSnapshot value) async {
                                BowlingTab.totalOver1 = value["TotalOver1"];
                                BowlingTab.totalOver1++;
                                await updateTotalOver1();
                                BowlingTab.totalballs1 = value["TotalBalls1"];
                                BowlingTab.totalballs1 = 0;
                                await updateTotalBalls1();
                                setState(() {
                                  BowlingTab.overballs.clear();
                                });
                              });
                              over = 0;
                              status = true;
                              runs = 0;
                              wicket = 0;

                              showmyDialog();
                            }
                          });
                          FirebaseFirestore.instance
                              .collection("Matches")
                              .doc(widget.selector)
                              .get()
                              .then((DocumentSnapshot value) async {
                            BowlingTab.team1Wickets = value["Team1Wicket"];
                            BowlingTab.team1Wickets++;
                            await updateTeam1Wickets();
                          });
                        },
                        child: const Text('wkt'),
                      ),
                      TextButton(
                        onPressed: () {
                          BowlingTab.bowlername = BowlingTab.strikeBowler;
                          FirebaseFirestore.instance
                              .collection("Matches")
                              .doc(widget.selector)
                              .collection("Inng1Bowler")
                              .doc(BowlingTab.bowlername)
                              .get()
                              .then((DocumentSnapshot value) async {
                            balls = value["Balls"];
                            if (balls < 6) {
                              balls = value["Balls"];
                              balls++;
                              runs = value["Runs"];
                              runs += 6;
                              await updateBowler(BowlingTab.bowlername);

                              //totalballs update
                              FirebaseFirestore.instance
                                  .collection("Matches")
                                  .doc(widget.selector)
                                  .get()
                                  .then((DocumentSnapshot value) async {
                                BowlingTab.totalballs1 = value["TotalBalls1"];
                                BowlingTab.totalballs1++;
                                await updateTotalBalls1();
                              });
                              BowlingTab.totalballs1 = 0;
                              setState(() {
                                BowlingTab.overballs.add("6");
                              });
                            } else {
                              balls = value["Balls"];
                              balls = 0;
                              over = value["Over"];
                              over++;
                              status = value['status'];
                              status = false;

                              await updateBowler(BowlingTab.bowlername);
                              //total update
                              FirebaseFirestore.instance
                                  .collection("Matches")
                                  .doc(widget.selector)
                                  .get()
                                  .then((DocumentSnapshot value) async {
                                BowlingTab.totalOver1 = value["TotalOver1"];
                                BowlingTab.totalOver1++;
                                await updateTotalOver1();
                                BowlingTab.totalballs1 = value["TotalBalls1"];
                                BowlingTab.totalballs1 = 0;
                                await updateTotalBalls1();
                                setState(() {
                                  BowlingTab.overballs.clear();
                                });
                              });
                              over = 0;
                              status = true;
                              runs = 0;

                              showmyDialog();
                            }
                          });
                        },
                        child: const Text('6'),
                      ),
                      TextButton(
                        onPressed: () {
                          BowlingTab.bowlername = BowlingTab.strikeBowler;
                          FirebaseFirestore.instance
                              .collection("Matches")
                              .doc(widget.selector)
                              .collection("Inng1Bowler")
                              .doc(BowlingTab.bowlername)
                              .get()
                              .then((DocumentSnapshot value) async {
                            balls = value["Balls"];
                            if (balls < 6) {
                              balls = value["Balls"];

                              runs = value["Runs"];
                              runs += 7;
                              await updateBowler(BowlingTab.bowlername);
                            }
                          });
                          setState(() {
                            BowlingTab.overballs.add("Nb6");
                          });
                        },
                        child: const Text('7'),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  debugprint(String s) {}
}

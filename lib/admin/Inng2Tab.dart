// import 'package:Score_Dekho/admin/Inng1Tab.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Inng1Tab.dart';

class Bowling1Tab extends StatefulWidget {
  const Bowling1Tab({Key? key, required this.selector}) : super(key: key);
  final String selector;
  static String bowlername1 = '';
  static String stricker1 = '';
  static String nonStricker1 = '';
  static int team2Wickets = 0;
  static String strikeBowler = '';
  static int totalballs2 = 0;
  static int totalOver2 = 0;
  static List<String> inng2Balls = [];

  @override
  _Bowling1TabState createState() => _Bowling1TabState();
}

class _Bowling1TabState extends State<Bowling1Tab> {
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
    String temp = Bowling1Tab.stricker1;
    Bowling1Tab.stricker1 = Bowling1Tab.nonStricker1;
    Bowling1Tab.nonStricker1 = temp;
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
                    Bowling1Tab.strikeBowler = value;
                  },
                ),
              ]),
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    Bowling1Tab.bowlername1 = Bowling1Tab.strikeBowler;
                    FirebaseFirestore.instance
                        .collection("Matches")
                        .doc(widget.selector)
                        .collection("Inng2Bowler")
                        .doc(Bowling1Tab.bowlername1)
                        .get()
                        .then((DocumentSnapshot value) async {
                      createBowler(Bowling1Tab.bowlername1);
                    });

                    Navigator.pop(context);
                  },
                  child: const Text("add")),
              TextButton(
                  onPressed: () async {
                    Bowling1Tab.bowlername1 = Bowling1Tab.strikeBowler;
                    FirebaseFirestore.instance
                        .collection("Matches")
                        .doc(widget.selector)
                        .collection("Inng2Bowler")
                        .doc(Bowling1Tab.bowlername1)
                        .get()
                        .then((DocumentSnapshot value) async {
                      over = value["Over"];
                      runs = value['Runs'];
                      wicket = value["Wicket"];
                      status = value["status"];
                      status = true;
                      await updateBowler(Bowling1Tab.bowlername1);
                    });

                    Navigator.pop(context);
                  },
                  child: const Text("select")),
            ],
          );
        });
  }

  createBowler(String bowler) {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("Matches")
        .doc(widget.selector)
        .collection("Inng2Bowler")
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
        .collection("Inng2Bowler")
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

  updateTeam2Score(team2score, team2wicket) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Matches").doc(widget.selector);

    Map<String, dynamic> team2data = {
      "Team2Score": team2score,
      "Team2Wicket": team2wicket
    };
    documentReference.update(team2data);
  }

  createBatsmanData(String playername) {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("Matches")
        .doc(widget.selector)
        .collection("Inng2Batsman")
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

  updateTeam2Wickets() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Matches").doc(widget.selector);

    Map<String, dynamic> twickets = {"Team2Wicket": Bowling1Tab.team2Wickets};
    documentReference.update(twickets).whenComplete(() => debugprint("updated"));
  }

  updatePlayerDataFor1() {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("Matches")
        .doc(widget.selector)
        .collection("Inng2Batsman")
        .doc(Bowling1Tab.stricker1);

    Map<String, dynamic> player = {
      "Name": Bowling1Tab.stricker1,
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

    Map<String, dynamic> tscore = {"Team2Score": localteamscore};
    documentReference.update(tscore).whenComplete(() => debugprint("updated"));
  }

  updateTotalOver2() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Matches").doc(widget.selector);

    Map<String, dynamic> totalOver1 = {"TotalOver2": Bowling1Tab.totalOver2};

    documentReference.update(totalOver1);
  }

  updateTotalBalls2() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Matches").doc(widget.selector);

    Map<String, dynamic> totalball1 = {"TotalBalls2": Bowling1Tab.totalballs2};

    documentReference.update(totalball1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: SingleChildScrollView(
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
                                      Bowling1Tab.strikeBowler = value;
                                    },
                                  ),
                                ]),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Bowling1Tab.bowlername1 =
                                          Bowling1Tab.strikeBowler;
                                      createBowler(Bowling1Tab.bowlername1);
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
                                      Bowling1Tab.stricker1 = value;
                                    },
                                  ),
                                  TextField(
                                    decoration: const InputDecoration(
                                      hintText: "Non Stricker",
                                    ),
                                    onChanged: (String value) {
                                      Bowling1Tab.nonStricker1 = value;
                                    },
                                  ),
                                ]),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      batsmanName = Bowling1Tab.stricker1;
                                      createBatsmanData(batsmanName);
                                    },
                                    child: const Text("stricker")),
                                TextButton(
                                    onPressed: () {
                                      batsmanName = Bowling1Tab.nonStricker1;
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
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        var team2score = snapshot.data;
                        var team2wicket = snapshot.data;
                        return Column(
                          children: [
                            Row(
                            children: [
                              Text(
                                team2score["Team2Score"].toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22.0),
                              ),
                              const Text(
                                '/',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22.0),
                              ),
                              Text(
                                team2wicket["Team2Wicket"].toString(),
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
                                    Bowling1Tab.team2Wickets = int.parse(value);
                                  },
                                ),
                              ]),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    updateTeamScore();
                                    updateTeam2Wickets();
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
                                    Bowling1Tab.totalOver2 = int.parse(value);
                                  },
                                ),
                                TextField(
                                  decoration: const InputDecoration(
                                    hintText: "Current Balls",
                                  ),
                                  onChanged: (String value) {
                                    Bowling1Tab.totalballs2 = int.parse(value);
                                  },
                                ),
                              ]),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    updateTotalOver2();
                                    updateTotalBalls2();
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
                              team2score["TotalOver2"].toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22.0),
                            ),
                            const Text(
                              '/',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22.0),
                            ),
                            Text(
                              team2wicket["TotalBalls2"].toString(),
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
                        ]
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)),
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(),
                          Text(
                            'Runs',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Balls',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '4s',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '6s',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  //stream builder for batsman
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Matches")
                          .doc(widget.selector)
                          .collection("Inng2Batsman")
                          .orderBy('created', descending: false)
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
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
                                                    Bowling1Tab.stricker1
                                                ? documentSnapshot["Name"] + "*"
                                                : documentSnapshot["Name"] +
                                                    " ",
                                            style: TextStyle(
                                                color: documentSnapshot[
                                                            "status"] ==
                                                        true
                                                    ? Colors.blue[400]
                                                    : Colors.grey[600],
                                                fontSize: 20.0),
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
                                          child: Text(documentSnapshot["six"]
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
                                .collection("Inng2Batsman")
                                .doc(Bowling1Tab.stricker1)
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
                            batsmanName = Bowling1Tab.stricker1;
                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .collection("Inng2Batsman")
                                .doc(Bowling1Tab.stricker1)
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
                                localteamscore = value["Team2Score"];
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
                            batsmanName = Bowling1Tab.stricker1;
                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .collection("Inng2Batsman")
                                .doc(Bowling1Tab.stricker1)
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
                              localteamscore = value["Team2Score"];
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
                              Bowling1Tab.team2Wickets =
                                  value["Team2Wicket"];
                            });
                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .collection("Inng2Batsman")
                                .doc(Bowling1Tab.stricker1)
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
                                          Bowling1Tab.stricker1 = value;
                                        },
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            batsmanName = Bowling1Tab.stricker1;
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
                            batsmanName = Bowling1Tab.stricker1;
                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .collection("Inng2Batsman")
                                .doc(Bowling1Tab.stricker1)
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
                                localteamscore = value["Team2Score"];
                                localteamscore += 3;
                                await updateTeamScore();
                              });
                            });
                          },
                          child: const Text('3'),
                        ),
                        TextButton(
                          onPressed: () {
                            batsmanName = Bowling1Tab.stricker1;
                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .collection("Inng2Batsman")
                                .doc(Bowling1Tab.stricker1)
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
                                localteamscore = value["Team2Score"];
                                localteamscore += 4;
                                await updateTeamScore();
                              });
                            });
                          },
                          child: const Text('4'),
                        ),
                        TextButton(
                         
                          onPressed: () {
                            batsmanName = Bowling1Tab.stricker1;
                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .collection("Inng2Batsman")
                                .doc(Bowling1Tab.stricker1)
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
                                localteamscore = value["Team2Score"];
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
                            Bowling1Tab.bowlername1 = Bowling1Tab.strikeBowler;
                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .get()
                                .then((DocumentSnapshot value) async {
                              localteamscore = value["Team2Score"];
                              localteamscore++;
                              await updateTeamScore();
                            });
                          },
                          child: const Text('wide'),
                        ),
                        TextButton(
                          onPressed: () {
                            batsmanName = Bowling1Tab.stricker1;
                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .collection("Inng2Batsman")
                                .doc(Bowling1Tab.stricker1)
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
                                localteamscore = value["Team2Score"];
                                localteamscore += 6;
                                await updateTeamScore();
                              });
                            });
                          },
                          child: const Text('6'),
                        ),
                        TextButton(
                          onPressed: () {
                            batsmanName = Bowling1Tab.stricker1;
                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .collection("Inng2Batsman")
                                .doc(Bowling1Tab.stricker1)
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
                                localteamscore = value["Team2Score"];
                                localteamscore += 7;
                                await updateTeamScore();
                              });
                            });
                          },
                          child: const Text('nb 6'),
                        ),
                        TextButton(
                      
                          onPressed: () {
                            batsmanName = Bowling1Tab.stricker1;
                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .collection("Inng2Batsman")
                                .doc(Bowling1Tab.stricker1)
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
                                localteamscore = value["Team2Score"];
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
                        batsmanName = Bowling1Tab.stricker1;
                        FirebaseFirestore.instance
                            .collection("Matches")
                            .doc(widget.selector)
                            .collection("Inng2Batsman")
                            .doc(Bowling1Tab.stricker1)
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
                            localteamscore = value["Team2Score"];
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0)),
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
                          .collection("Inng2Bowler")
                          .snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
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
                                                    Bowling1Tab.strikeBowler
                                                ? documentSnapshot["Name"] + "*"
                                                : documentSnapshot["Name"] +
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
                            Bowling1Tab.bowlername1 = Bowling1Tab.strikeBowler;
                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .collection("Inng2Bowler")
                                .doc(Bowling1Tab.bowlername1)
                                .get()
                                .then((DocumentSnapshot value) async {
                              balls = value["Balls"];
                              if (balls < 6) {
                                balls++;
                                await updateBowler(Bowling1Tab.bowlername1);
                                //totalballs update
                                FirebaseFirestore.instance
                                    .collection("Matches")
                                    .doc(widget.selector)
                                    .get()
                                    .then((DocumentSnapshot value) async {
                                  Bowling1Tab.totalballs2 =
                                      value["TotalBalls2"];
                                  Bowling1Tab.totalballs2++;
                                  await updateTotalBalls2();
                                });
                                balls = 0;
                                Bowling1Tab.totalballs2 = 0;
                                setState(() {
                                  Bowling1Tab.inng2Balls.add("0");
                                });
                                balls = 0;
                              } else {
                                over = value["Over"];
                                over++;
                                balls = value["Balls"];
                                balls = 0;
                                status = value["status"];
                                status = false;
                                await updateBowler(Bowling1Tab.bowlername1);
                                //total update
                                FirebaseFirestore.instance
                                    .collection("Matches")
                                    .doc(widget.selector)
                                    .get()
                                    .then((DocumentSnapshot value) async {
                                  Bowling1Tab.totalOver2 =
                                      value["TotalOver2"];
                                  Bowling1Tab.totalOver2++;
                                  await updateTotalOver2();
                                  Bowling1Tab.totalballs2 =
                                      value["TotalBalls2"];
                                  Bowling1Tab.totalballs2 = 0;
                                  await updateTotalBalls2();

                                  setState(() {
                                    Bowling1Tab.inng2Balls.clear();
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
                            Bowling1Tab.bowlername1 = Bowling1Tab.strikeBowler;
                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .collection("Inng2Bowler")
                                .doc(Bowling1Tab.bowlername1)
                                .get()
                                .then((DocumentSnapshot value) async {
                              balls = value["Balls"];
                              if (balls < 6) {
                                balls = value["Balls"];
                                balls++;
                                runs = value["Runs"];
                                runs++;
                                await updateBowler(Bowling1Tab.bowlername1);
                                //totalballs update
                                FirebaseFirestore.instance
                                    .collection("Matches")
                                    .doc(widget.selector)
                                    .get()
                                    .then((DocumentSnapshot value) async {
                                  Bowling1Tab.totalballs2 =
                                      value["TotalBalls2"];
                                  Bowling1Tab.totalballs2++;
                                  await updateTotalBalls2();
                                });
                                Bowling1Tab.totalballs2 = 0;
                                setState(() {
                                  Bowling1Tab.inng2Balls.add("1");
                                });
                              } else {
                                balls = value["Balls"];
                                balls = 0;
                                over = value["Over"];
                                over++;
                                status = value['status'];
                                status = false;

                                await updateBowler(Bowling1Tab.bowlername1);
                                //total update
                                FirebaseFirestore.instance
                                    .collection("Matches")
                                    .doc(widget.selector)
                                    .get()
                                    .then((DocumentSnapshot value) async {
                                  Bowling1Tab.totalOver2 =
                                      value["TotalOver2"];
                                  Bowling1Tab.totalOver2++;
                                  await updateTotalOver2();
                                  Bowling1Tab.totalballs2 =
                                      value["TotalBalls2"];
                                  Bowling1Tab.totalballs2 = 0;
                                  await updateTotalBalls2();
                                  setState(() {
                                    Bowling1Tab.inng2Balls.clear();
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
                            Bowling1Tab.bowlername1 = Bowling1Tab.strikeBowler;
                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .collection("Inng2Bowler")
                                .doc(Bowling1Tab.bowlername1)
                                .get()
                                .then((DocumentSnapshot value) async {
                              balls = value["Balls"];
                              if (balls < 6) {
                                balls = value["Balls"];
                                balls++;
                                runs = value["Runs"];
                                runs += 2;
                                await updateBowler(Bowling1Tab.bowlername1);
                                //totalballs update
                                FirebaseFirestore.instance
                                    .collection("Matches")
                                    .doc(widget.selector)
                                    .get()
                                    .then((DocumentSnapshot value) async {
                                  Bowling1Tab.totalballs2 =
                                      value["TotalBalls2"];
                                  Bowling1Tab.totalballs2++;
                                  await updateTotalBalls2();
                                });
                                Bowling1Tab.totalballs2 = 0;
                                setState(() {
                                  Bowling1Tab.inng2Balls.add("2");
                                });
                              } else {
                                balls = value["Balls"];
                                balls = 0;
                                over = value["Over"];
                                over++;
                                status = value['status'];
                                status = false;

                                await updateBowler(Bowling1Tab.bowlername1);
                                //total update
                                FirebaseFirestore.instance
                                    .collection("Matches")
                                    .doc(widget.selector)
                                    .get()
                                    .then((DocumentSnapshot value) async {
                                  Bowling1Tab.totalOver2 =
                                      value["TotalOver2"];
                                  Bowling1Tab.totalOver2++;
                                  await updateTotalOver2();
                                  Bowling1Tab.totalballs2 =
                                      value["TotalBalls2"];
                                  Bowling1Tab.totalballs2 = 0;
                                  await updateTotalBalls2();
                                  setState(() {
                                    Bowling1Tab.inng2Balls.clear();
                                  });
                                });
                                over = 0;
                                status = true;
                                runs = 0;

                                showmyDialog();
                              }
                              FirebaseFirestore.instance
                                  .collection("Matches")
                                  .doc(widget.selector)
                                  .get()
                                  .then((DocumentSnapshot value) {
                                var team2score = value["Team2Score"];

                                var team2wicket = value["Team2Wicket"];

                                updateTeam2Score(team2score, team2wicket);
                              });
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
                            Bowling1Tab.bowlername1 = Bowling1Tab.strikeBowler;
                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .collection("Inng2Bowler")
                                .doc(Bowling1Tab.bowlername1)
                                .get()
                                .then((DocumentSnapshot value) async {
                              balls = value["Balls"];
                              if (balls < 6) {
                                balls = value["Balls"];

                                runs = value["Runs"];
                                runs++;
                                await updateBowler(Bowling1Tab.bowlername1);
                              }
                            });
                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .get()
                                .then((DocumentSnapshot value) {
                              var team2score = value["Team2Score"];

                              var team2wicket = value["Team2Wicket"];

                              updateTeam2Score(team2score, team2wicket);
                            });
                            setState(() {
                              Bowling1Tab.inng2Balls.add("wd");
                            });
                          },
                          child: const Text('Wide'),
                        ),
                        TextButton(
                          onPressed: () {
                            Bowling1Tab.bowlername1 = Bowling1Tab.strikeBowler;
                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .collection("Inng2Bowler")
                                .doc(Bowling1Tab.bowlername1)
                                .get()
                                .then((DocumentSnapshot value) async {
                              balls = value["Balls"];
                              if (balls < 6) {
                                balls = value["Balls"];
                                balls++;
                                runs = value["Runs"];
                                runs += 3;
                                await updateBowler(Bowling1Tab.bowlername1);
                                //totalballs update
                                FirebaseFirestore.instance
                                    .collection("Matches")
                                    .doc(widget.selector)
                                    .get()
                                    .then((DocumentSnapshot value) async {
                                  Bowling1Tab.totalballs2 =
                                      value["TotalBalls2"];
                                  Bowling1Tab.totalballs2++;
                                  await updateTotalBalls2();
                                });
                                Bowling1Tab.totalballs2 = 0;
                                setState(() {
                                  Bowling1Tab.inng2Balls.add("3");
                                });
                              } else {
                                balls = value["Balls"];
                                balls = 0;
                                over = value["Over"];
                                over++;
                                status = value['status'];
                                status = false;

                                await updateBowler(Bowling1Tab.bowlername1);
                                //total update
                                FirebaseFirestore.instance
                                    .collection("Matches")
                                    .doc(widget.selector)
                                    .get()
                                    .then((DocumentSnapshot value) async {
                                  Bowling1Tab.totalOver2 =
                                      value["TotalOver2"];
                                  Bowling1Tab.totalOver2++;
                                  await updateTotalOver2();
                                  Bowling1Tab.totalballs2 =
                                      value["TotalBalls2"];
                                  Bowling1Tab.totalballs2 = 0;
                                  await updateTotalBalls2();
                                  setState(() {
                                    Bowling1Tab.inng2Balls.clear();
                                  });
                                });
                                over = 0;
                                status = true;
                                runs = 0;

                                showmyDialog();
                              }
                            });
                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .get()
                                .then((DocumentSnapshot value) {
                              var team2score = value["Team2Score"];

                              var team2wicket = value["Team2Wicket"];

                              updateTeam2Score(team2score, team2wicket);
                            });
                          },
                          child: const Text('3'),
                        ),
                        TextButton(
                          onPressed: () {
                            Bowling1Tab.bowlername1 = Bowling1Tab.strikeBowler;
                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .collection("Inng2Bowler")
                                .doc(Bowling1Tab.bowlername1)
                                .get()
                                .then((DocumentSnapshot value) async {
                              balls = value["Balls"];
                              if (balls < 6) {
                                balls = value["Balls"];
                                balls++;
                                runs = value["Runs"];
                                runs += 4;
                                await updateBowler(Bowling1Tab.bowlername1);
                                //totalballs update
                                FirebaseFirestore.instance
                                    .collection("Matches")
                                    .doc(widget.selector)
                                    .get()
                                    .then((DocumentSnapshot value) async {
                                  Bowling1Tab.totalballs2 =
                                      value["TotalBalls2"];
                                  Bowling1Tab.totalballs2++;
                                  await updateTotalBalls2();
                                });
                                Bowling1Tab.totalballs2 = 0;
                                setState(() {
                                  Bowling1Tab.inng2Balls.add("4");
                                });
                              } else {
                                balls = value["Balls"];
                                balls = 0;
                                over = value["Over"];
                                over++;
                                status = value['status'];
                                status = false;

                                await updateBowler(Bowling1Tab.bowlername1);
                                //total update
                                FirebaseFirestore.instance
                                    .collection("Matches")
                                    .doc(widget.selector)
                                    .get()
                                    .then((DocumentSnapshot value) async {
                                  Bowling1Tab.totalOver2 =
                                      value["TotalOver2"];
                                  Bowling1Tab.totalOver2++;
                                  await updateTotalOver2();
                                  Bowling1Tab.totalballs2 =
                                      value["TotalBalls2"];
                                  Bowling1Tab.totalballs2 = 0;
                                  await updateTotalBalls2();
                                  setState(() {
                                    Bowling1Tab.inng2Balls.clear();
                                  });
                                });
                                over = 0;
                                status = true;
                                runs = 0;

                                showmyDialog();
                              }
                            });
                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .get()
                                .then((DocumentSnapshot value) {
                              var team2score = value["Team2Score"];

                              var team2wicket = value["Team2Wicket"];

                              updateTeam2Score(team2score, team2wicket);
                            });
                          },
                          child: const Text('4'),
                        ),
                        TextButton(
                        
                          onPressed: () {
                            Bowling1Tab.bowlername1 = Bowling1Tab.strikeBowler;
                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .collection("Inng2Bowler")
                                .doc(Bowling1Tab.bowlername1)
                                .get()
                                .then((DocumentSnapshot value) async {
                              balls = value["Balls"];
                              if (balls < 6) {
                                balls = value["Balls"];

                                runs = value["Runs"];
                                runs += 5;
                                await updateBowler(Bowling1Tab.bowlername1);
                              }
                            });
                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .get()
                                .then((DocumentSnapshot value) {
                              var team2score = value["Team2Score"];

                              var team2wicket = value["Team2Wicket"];

                              updateTeam2Score(team2score, team2wicket);
                            });
                            setState(() {
                              Bowling1Tab.inng2Balls.add("Wd4");
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
                            Bowling1Tab.bowlername1 = Bowling1Tab.strikeBowler;
                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .collection("Inng2Bowler")
                                .doc(Bowling1Tab.bowlername1)
                                .get()
                                .then((DocumentSnapshot value) async {
                              balls = value["Balls"];
                              if (balls < 6) {
                                balls = value["Balls"];

                                runs = value["Runs"];
                                runs++;
                                await updateBowler(Bowling1Tab.bowlername1);
                              }
                            });
                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .get()
                                .then((DocumentSnapshot value) {
                              var team2score = value["Team2Score"];
                              team2score += 1;
                              var team2wicket = value["Team2Wicket"];

                              updateTeam2Score(team2score, team2wicket);
                            });
                            setState(() {
                              Bowling1Tab.inng2Balls.add("Nb");
                            });
                          },
                          child: const Text('NoBall'),
                        ),
                        TextButton(
                          onPressed: () {
                            Bowling1Tab.bowlername1 = Bowling1Tab.strikeBowler;
                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .collection("Inng2Bowler")
                                .doc(Bowling1Tab.bowlername1)
                                .get()
                                .then((DocumentSnapshot value) async {
                              balls = value["Balls"];
                              if (balls < 6) {
                                balls = value["Balls"];
                                balls++;
                                runs = value["Runs"];
                                wicket = value["Wicket"];
                                wicket++;
                                await updateBowler(Bowling1Tab.bowlername1);
                                //totalballs update
                                FirebaseFirestore.instance
                                    .collection("Matches")
                                    .doc(widget.selector)
                                    .get()
                                    .then((DocumentSnapshot value) async {
                                  Bowling1Tab.totalballs2 =
                                      value["TotalBalls2"];
                                  Bowling1Tab.totalballs2++;
                                  await updateTotalBalls2();
                                });
                                Bowling1Tab.totalballs2 = 0;
                                setState(() {
                                  Bowling1Tab.inng2Balls.add("Wkt");
                                });
                              } else {
                                balls = value["Balls"];
                                balls = 0;
                                over = value["Over"];
                                over++;
                                status = value['status'];
                                status = false;

                                await updateBowler(Bowling1Tab.bowlername1);
                                //total update
                                FirebaseFirestore.instance
                                    .collection("Matches")
                                    .doc(widget.selector)
                                    .get()
                                    .then((DocumentSnapshot value) async {
                                  Bowling1Tab.totalOver2 =
                                      value["TotalOver2"];
                                  Bowling1Tab.totalOver2++;
                                  await updateTotalOver2();
                                  Bowling1Tab.totalballs2 =
                                      value["TotalBalls2"];
                                  Bowling1Tab.totalballs2 = 0;
                                  await updateTotalBalls2();
                                  setState(() {
                                    Bowling1Tab.inng2Balls.clear();
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
                              // var team2score = value.data()["Team2Score"];
                              // var team2wicket = value.data()["Team2Wicket"];
                              Bowling1Tab.team2Wickets =
                                  value["Team2Wicket"];
                              Bowling1Tab.team2Wickets++;
                              await updateTeam2Wickets();
                              // updateTeam2Score(team2score, team2wicket);
                            });
                          },
                          child: const Text('wkt'),
                        ),
                        TextButton(
                          onPressed: () {
                            Bowling1Tab.bowlername1 = Bowling1Tab.strikeBowler;
                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .collection("Inng2Bowler")
                                .doc(Bowling1Tab.bowlername1)
                                .get()
                                .then((DocumentSnapshot value) async {
                              balls = value["Balls"];
                              if (balls < 6) {
                                balls = value["Balls"];
                                balls++;
                                runs = value["Runs"];
                                runs += 6;
                                await updateBowler(Bowling1Tab.bowlername1);
                                //totalballs update
                                FirebaseFirestore.instance
                                    .collection("Matches")
                                    .doc(widget.selector)
                                    .get()
                                    .then((DocumentSnapshot value) async {
                                  Bowling1Tab.totalballs2 =
                                      value["TotalBalls2"];
                                  Bowling1Tab.totalballs2++;
                                  await updateTotalBalls2();
                                });
                                BowlingTab.totalballs1 = 0;
                                setState(() {
                                  Bowling1Tab.inng2Balls.add("6");
                                });
                              } else {
                                balls = value["Balls"];
                                balls = 0;
                                over = value["Over"];
                                over++;
                                status = value['status'];
                                status = false;

                                await updateBowler(Bowling1Tab.bowlername1);
                                //total update
                                FirebaseFirestore.instance
                                    .collection("Matches")
                                    .doc(widget.selector)
                                    .get()
                                    .then((DocumentSnapshot value) async {
                                  Bowling1Tab.totalOver2 =
                                      value["TotalOver2"];
                                  Bowling1Tab.totalOver2++;
                                  await updateTotalOver2();
                                  Bowling1Tab.totalballs2 =
                                      value["TotalBalls2"];
                                  Bowling1Tab.totalballs2 = 0;
                                  await updateTotalBalls2();
                                  setState(() {
                                    Bowling1Tab.inng2Balls.clear();
                                  });
                                });
                                over = 0;
                                status = true;
                                runs = 0;

                                showmyDialog();
                              }
                            });
                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .get()
                                .then((DocumentSnapshot value) {
                              var team2score = value["Team2Score"];

                              var team2wicket = value["Team2Wicket"];

                              updateTeam2Score(team2score, team2wicket);
                            });
                          },
                          child: const Text('6'),
                        ),
                        TextButton(
                         
                          onPressed: () {
                            Bowling1Tab.bowlername1 = Bowling1Tab.strikeBowler;
                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .collection("Inng2Bowler")
                                .doc(Bowling1Tab.bowlername1)
                                .get()
                                .then((DocumentSnapshot value) async {
                              balls = value["Balls"];
                              if (balls < 6) {
                                balls = value["Balls"];

                                runs = value["Runs"];
                                runs += 7;
                                await updateBowler(Bowling1Tab.bowlername1);
                              }
                            });
                            FirebaseFirestore.instance
                                .collection("Matches")
                                .doc(widget.selector)
                                .get()
                                .then((DocumentSnapshot value) {
                              var team2score = value["Team2Score"];

                              var team2wicket = value["Team2Wicket"];

                              updateTeam2Score(team2score, team2wicket);
                            });
                            setState(() {
                              Bowling1Tab.inng2Balls.add("Nb6");
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
      ),
    );
  }

  debugprint(String s) {}
}

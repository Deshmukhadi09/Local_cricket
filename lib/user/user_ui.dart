// import 'package:Score_Dekho/admin/Inng2Tab.dart';
// import 'package:Score_Dekho/admin/squads.dart';

// import 'package:Score_Dekho/admin/Inng1Tab.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_score_app/admin/Inng1Tab.dart';

// import 'Inng1Tab.dart';

class UserUi extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const UserUi(
      {required this.selector,
      required this.team1,
      required this.team2,
      required this.team1logo,
      required this.team2logo});
  final String selector;
  final String team1;
  final String team2;
  final String team1logo;
  final String team2logo;
  @override
  _UserUiState createState() => _UserUiState();
}

class _UserUiState extends State<UserUi> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple,
            title: const Text(
              'user screen',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  child: Text(
                    'Team Squads',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    'Ing-1',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    'Ing-2',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              //tab1 content
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        widget.team1,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ),

                    //streambuilder for team1

                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Matches")
                            .doc(widget.selector)
                            .collection("Team1Squad")
                            .orderBy('created', descending: false)
                            .snapshots(),

                        // .orderBy('created', descending: false)

                        builder:
                            (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                   Map<String,dynamic> documentSnapshot =
                                      snapshot.data!.docs[index].data();
                                  return Card(
                                    child: ListTile(
                                      leading: const CircleAvatar(
                                        radius: 14.0,
                                        backgroundImage: AssetImage(
                                            "assets/images/cricket.png"),
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
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
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
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> documentSnapshot =
                                      snapshot.data!.docs[index].data();
                                  return Card(
                                    child: ListTile(
                                      leading: const CircleAvatar(
                                        radius: 14.0,
                                        backgroundImage: AssetImage(
                                            "assets/images/cricket.png"),
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
              // Squads(
              //     selector: widget.selector,
              //     team1: widget.team1,
              //     team2: widget.team2),
//tab2 content
              //Second container
              Container(
                color: Colors.grey[200],
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 15),
                            child: Container(
                              height: 164,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Team\'s Score',
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 17.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                  //here i have change the row to wrap widget
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: Image.network(
                                          widget.team1logo,
                                          height: 70,
                                        ),
                                      ),
                                      //stream Builder1
                                      StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection("Matches")
                                              .doc(widget.selector)
                                              .snapshots(),
                                          builder: (context,
                                              AsyncSnapshot snapshot) {
                                            if (snapshot.hasData) {
                                              var team1score = snapshot.data;
                                              var team1wicket = snapshot.data;
                                              var totalover1 = snapshot.data;
                                              var totalballs = snapshot.data;
                                              return Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        team1score["Team1Score"]
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 25.0),
                                                      ),
                                                      const Text(
                                                        '/',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 25.0),
                                                      ),
                                                      Text(
                                                        team1wicket[
                                                                "Team1Wicket"]
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 25.0),
                                                      )
                                                    ],
                                                  ),
                                                  Text(
                                                      "(${totalover1['TotalOver1'].toString()}.${totalballs['TotalBalls1'].toString()})",
                                                      style: const TextStyle(
                                                          fontSize: 15.0))
                                                ],
                                              );
                                            } else {
                                              return const Text("0");
                                            }
                                          }),
                                      Image.asset(
                                        'assets/images/vs1-removebg-preview.png',
                                        height: 50,
                                        width: 50,
                                      ),
                                      //stream builder 2
                                      StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection("Matches")
                                              .doc(widget.selector)
                                              .snapshots(),
                                          builder: (context,
                                              AsyncSnapshot snapshot) {
                                            if (snapshot.hasData) {
                                              var team2score = snapshot.data;
                                              var team2wicket = snapshot.data;
                                              var totalover2 = snapshot.data;
                                              var totalballs2 = snapshot.data;
                                              return Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        team2score["Team2Score"]
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 25.0),
                                                      ),
                                                      const Text(
                                                        '/',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 25.0),
                                                      ),
                                                      Text(
                                                        team2wicket[
                                                                "Team2Wicket"]
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 25.0),
                                                      )
                                                    ],
                                                  ),
                                                  Text(
                                                      "(${totalover2['TotalOver2'].toString()}.${totalballs2['TotalBalls2'].toString()})",
                                                      style: const TextStyle(
                                                          fontSize: 15.0))
                                                ],
                                              );
                                            } else {
                                              return const Text("0");
                                            }
                                          }),
                                      Expanded(
                                        // child: Text("team2 logo"),
                                        child: Image.network(
                                          widget.team2logo,
                                          height: 70,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //third container

                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 15, bottom: 10.0),
                            child: Container(
                              // constraints: BoxConstraints(minHeight: 30.0, maxHeight: 500),
                              //height: 500,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 0.0),
                                    child: Container(
                                      height: 30,
                                      decoration: const BoxDecoration(
                                        color: Colors.purple,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15.0),
                                            topRight: Radius.circular(15.0)),
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: const [
                                            Text(
                                              'Batsman  ',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Text(
                                              'Runs',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Balls   ',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '4s    ',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '6s    ',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
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
                                          AsyncSnapshot<
                                                  QuerySnapshot<
                                                      Map<String, dynamic>>>
                                              snapshot) {
                                        if (snapshot.hasData) {
                                          return ListView.builder(
                                              shrinkWrap: true,
                                              physics: const ScrollPhysics(),
                                              itemCount:
                                                  snapshot.data!.docs.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                Map<String, dynamic>
                                                    documentSnapshot = snapshot
                                                        .data!.docs[index]
                                                        .data();
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0,
                                                          top: 10.0),
                                                  child: Card(
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 4,
                                                          child: Text(
                                                            documentSnapshot[
                                                                        "Name"] ==
                                                                    BowlingTab
                                                                        .stricker
                                                                ? documentSnapshot[
                                                                        "Name"] +
                                                                    "*"
                                                                : documentSnapshot[
                                                                        "Name"] +
                                                                    " ",
                                                            style: TextStyle(
                                                                color: documentSnapshot["status"] ==
                                                                        "true"
                                                                    ? Colors.blue[
                                                                        400]
                                                                    : Colors.grey[
                                                                        600],
                                                                fontSize: 17.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 35.0),
                                                        Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                                documentSnapshot[
                                                                        "Runs"]
                                                                    .toString())),
                                                        //SizedBox(width: 25.0),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                              documentSnapshot[
                                                                      "Balls"]
                                                                  .toString()),
                                                        ),
                                                        //SizedBox(width: 20.0),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                              documentSnapshot[
                                                                      "four"]
                                                                  .toString()),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                              documentSnapshot[
                                                                      "six"]
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
                          ),
                          const Divider(),
                          //Bowler Container
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10, top: 15, bottom: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 0.0),
                                    child: Container(
                                      height: 30,
                                      decoration: const BoxDecoration(
                                        color: Colors.purple,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15.0),
                                            topRight: Radius.circular(15.0)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: const [
                                          Flexible(
                                            child: Text(
                                              'Bowler',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20.0,
                                          ),
                                          Text(
                                            'Over',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Runs',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: Text(
                                              'Wicket',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //stream builder
                                  StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection("Matches")
                                          .doc(widget.selector)
                                          .collection("Inng1Bowler")
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<
                                                  QuerySnapshot<
                                                      Map<String, dynamic>>>
                                              snapshot) {
                                        if (snapshot.hasData) {
                                          return ListView.builder(
                                              physics: const ScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount:
                                                  snapshot.data!.docs.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                Map<String, dynamic>
                                                    documentSnapshot = snapshot
                                                        .data!.docs[index]
                                                        .data();
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0,
                                                          top: 10.0),
                                                  child: Card(
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 4,
                                                          child: Text(
                                                            documentSnapshot[
                                                                        "Name"] ==
                                                                    BowlingTab
                                                                        .strikeBowler
                                                                ? documentSnapshot[
                                                                        "Name"] +
                                                                    "*"
                                                                : documentSnapshot[
                                                                        "Name"] +
                                                                    " ",
                                                            style: TextStyle(
                                                                color: documentSnapshot["status"] ==
                                                                        "true"
                                                                    ? Colors.blue[
                                                                        400]
                                                                    : Colors.grey[
                                                                        600],
                                                                fontSize: 17.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
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
                                                          child: Text(
                                                              documentSnapshot[
                                                                      "Runs"]
                                                                  .toString()),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Text(
                                                              documentSnapshot[
                                                                      "Wicket"]
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
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              //tab3 content
              Container(
                color: Colors.grey[200],
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 15),
                            child: Container(
                              height: 164,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Team\'s Score',
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 17.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        // child: Text("team1logo"),
                                        child: Image.network(
                                          widget.team1logo,
                                          height: 70,
                                        ),
                                      ),

                                      //stream Builder1
                                      StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection("Matches")
                                              .doc(widget.selector)
                                              .snapshots(),
                                          builder: (context,
                                              AsyncSnapshot snapshot) {
                                            if (snapshot.hasData) {
                                              var team1score = snapshot.data;
                                              var team1wicket = snapshot.data;
                                              var totalover1 = snapshot.data;
                                              var totalballs1 = snapshot.data;
                                              return Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        team1score["Team1Score"]
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 25.0),
                                                      ),
                                                      const Text(
                                                        '/',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 25.0),
                                                      ),
                                                      Text(
                                                        team1wicket[
                                                                "Team1Wicket"]
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 25.0),
                                                      )
                                                    ],
                                                  ),
                                                  Text(
                                                      "(${totalover1['TotalOver1'].toString()}.${totalballs1['TotalBalls1'].toString()})",
                                                      style: const TextStyle(
                                                          fontSize: 15.0))
                                                ],
                                              );
                                            } else {
                                              return const Text("0");
                                            }
                                          }),
                                      Image.asset(
                                        'assets/images/vs1-removebg-preview.png',
                                        height: 50,
                                        width: 50,
                                      ),
                                      //Streambuilder 2
                                      StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection("Matches")
                                              .doc(widget.selector)
                                              .snapshots(),
                                          builder: (context,
                                              AsyncSnapshot snapshot) {
                                            if (snapshot.hasData) {
                                              var team2score = snapshot.data;
                                              var team2wicket = snapshot.data;
                                              var totalover2 = snapshot.data;
                                              var totalballs2 = snapshot.data;
                                              return Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        team2score["Team2Score"]
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 25.0),
                                                      ),
                                                      const Text(
                                                        '/',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 25.0),
                                                      ),
                                                      Text(
                                                        team2wicket[
                                                                "Team2Wicket"]
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 25.0),
                                                      )
                                                    ],
                                                  ),
                                                  Text(
                                                      "(${totalover2['TotalOver2'].toString()}.${totalballs2['TotalBalls2'].toString()})",
                                                      style: const TextStyle(
                                                          fontSize: 15.0))
                                                ],
                                              );
                                            } else {
                                              return const Text("0");
                                            }
                                          }),
                                      Expanded(
                                        // child: Text("team1logo"),
                                        child: Image.network(
                                          widget.team2logo,
                                          height: 70,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10.0,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          //inn2 batsman container
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 15, bottom: 10.0),
                            child: Container(
                              // constraints: BoxConstraints(minHeight: 30.0, maxHeight: 500),
                              //height: 500,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 0.0),
                                    child: Container(
                                      height: 30,
                                      decoration: const BoxDecoration(
                                        color: Colors.purple,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15.0),
                                            topRight: Radius.circular(15.0)),
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: const [
                                            Text(
                                              'Batsman',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(),
                                            Text(
                                              'Runs  ',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              'Balls  ',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '4s   ',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              '6s',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  //stream builder for batsman
                                  StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection("Matches")
                                          .doc(widget.selector)
                                          .collection("Inng2Batsman")
                                          .orderBy('created', descending: false)
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<
                                                  QuerySnapshot<
                                                      Map<String, dynamic>>>
                                              snapshot) {
                                        if (snapshot.hasData) {
                                          return ListView.builder(
                                              shrinkWrap: true,
                                              physics: const ScrollPhysics(),
                                              itemCount:
                                                  snapshot.data!.docs.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                Map<String, dynamic>
                                                    documentSnapshot = snapshot
                                                        .data!.docs[index]
                                                        .data();
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0,
                                                          top: 10.0),
                                                  child: Card(
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 4,
                                                          child: Text(
                                                            documentSnapshot[
                                                                        "Name"] ==
                                                                    BowlingTab
                                                                        .stricker
                                                                ? documentSnapshot[
                                                                        "Name"] +
                                                                    "*"
                                                                : documentSnapshot[
                                                                        "Name"] +
                                                                    " ",
                                                            style: TextStyle(
                                                                color: documentSnapshot["status"] ==
                                                                        "true"
                                                                    ? Colors.blue[
                                                                        400]
                                                                    : Colors.grey[
                                                                        600],
                                                                fontSize: 17.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 50.0),
                                                        Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                                documentSnapshot[
                                                                        "Runs"]
                                                                    .toString())),
                                                        const SizedBox(
                                                            width: 25.0),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                              documentSnapshot[
                                                                      "Balls"]
                                                                  .toString()),
                                                        ),
                                                        const SizedBox(
                                                            width: 20.0),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                              documentSnapshot[
                                                                      "four"]
                                                                  .toString()),
                                                        ),
                                                        const SizedBox(
                                                            width: 20.0),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                              documentSnapshot[
                                                                      "six"]
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
                          ),
                          const Divider(),
                          //Bowler Container
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10, top: 15, bottom: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 0.0),
                                    child: Container(
                                      height: 30,
                                      decoration: const BoxDecoration(
                                        color: Colors.purple,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15.0),
                                            topRight: Radius.circular(15.0)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: const [
                                          Text(
                                            'Bowler',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(width: 20),
                                          Text(
                                            'Over',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Runs',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            'Wicket',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 3.0,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                  //stream builder
                                  StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection("Matches")
                                          .doc(widget.selector)
                                          .collection("Inng2Bowler")
                                          .snapshots(),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        if (snapshot.hasData) {
                                          return ListView.builder(
                                              physics: const ScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount:
                                                  snapshot.data?.docs.length,
                                              itemBuilder: (context, index) {
                                                DocumentSnapshot
                                                    documentSnapshot =
                                                    snapshot.data?.docs[index]
                                                        as DocumentSnapshot<
                                                            Object?>;
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0,
                                                          top: 10.0),
                                                  child: Card(
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 4,
                                                          child: Text(
                                                            documentSnapshot[
                                                                        "Name"] ==
                                                                    BowlingTab
                                                                        .strikeBowler
                                                                ? documentSnapshot[
                                                                        "Name"] +
                                                                    "*"
                                                                : documentSnapshot[
                                                                        "Name"] +
                                                                    " ",
                                                            style: TextStyle(
                                                                color: documentSnapshot["status"] ==
                                                                        "true"
                                                                    ? Colors.blue[
                                                                        400]
                                                                    : Colors.grey[
                                                                        600],
                                                                fontSize: 17.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
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
                                                          child: Text(
                                                              documentSnapshot[
                                                                      "Runs"]
                                                                  .toString()),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                              documentSnapshot[
                                                                      "Wicket"]
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
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

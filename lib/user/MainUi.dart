//import 'package:Score_Dekho/admin/admin_match_fixture.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_score_app/user/user_ui.dart';


class MainUI extends StatefulWidget {
  const MainUI({Key? key}) : super(key: key);

  @override
  _MainUIState createState() => _MainUIState();
}

class _MainUIState extends State<MainUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: const Text('Live scorer '),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 220,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  CarouselSlider(
                      items: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12.0),
                            image: const DecorationImage(
                                image: AssetImage('assets/images/adi1.png'),
                                fit: BoxFit.fitHeight),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12.0),
                            image: const DecorationImage(
                                image: AssetImage('assets/images/adi2.png'),
                                fit: BoxFit.fitHeight),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12.0),
                            image: const DecorationImage(
                                image: AssetImage('assets/images/adi3.png'),
                                fit: BoxFit.fitHeight),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12.0),
                            image: const DecorationImage(
                                image: AssetImage('assets/images/adi4.png'),
                                fit: BoxFit.fitHeight),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12.0),
                            image: const DecorationImage(
                                image: AssetImage('assets/images/adi5.png'),
                                fit: BoxFit.fitHeight),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12.0),
                            image: const DecorationImage(
                                image: AssetImage('assets/images/adi6.png'),
                                fit: BoxFit.fitHeight),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12.0),
                            image: const DecorationImage(
                                image: AssetImage('assets/images/adi7.png'),
                                fit: BoxFit.fitHeight),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12.0),
                            image: const DecorationImage(
                                image: AssetImage('assets/images/adi8.png'),
                                fit: BoxFit.fitHeight),
                          ),
                        ),
                      ],
                      options: CarouselOptions(
                          height: 200,
                          viewportFraction: 0.8,
                          aspectRatio: 16 / 9,
                          enlargeCenterPage: true,
                          autoPlay: true))
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10, top: 10, bottom: 10),
              child: Container(
                height: 110,
                width: 330,
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 2.0,
                          offset: Offset(0.5, 1.0),
                          blurRadius: 2.0)
                    ],
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Cricket For Unity',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    //circle avatar
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/mypic.jpg'),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      'Aditya Deshmukh',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Matches',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Matches")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map<String, dynamic> documentSnapshot =
                            snapshot.data!.docs[index].data();
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return UserUi(
                                selector:
                                    documentSnapshot["match Number"].toString(),
                                team1: documentSnapshot["Team1"].toString(),
                                team2: documentSnapshot["Team2"].toString(),
                                team1logo:
                                    documentSnapshot["Team1logo"].toString(),
                                team2logo:
                                    documentSnapshot["Team2logo"].toString(),
                              );
                            }));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.grey,
                                        spreadRadius: 2.0,
                                        offset: Offset(0.5, 1.0),
                                        blurRadius: 2.0)
                                  ],
                                  borderRadius: BorderRadius.circular(10.0)),
                              height: 230.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Match No: ${documentSnapshot["match Number"]}'
                                              .toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 180.0),
                                          child: SizedBox(
                                            width: 60,
                                            height: 25,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary:
                                                    documentSnapshot["status"] == true
                                                        ? Colors.red
                                                        : Colors.grey,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                ),
                                              ),
                                              onPressed: () {},
                                              child: const Text(
                                                'Live',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Image.network(
                                            documentSnapshot["Team1logo"],
                                            height: 50,
                                          ),
                                          Text(
                                            documentSnapshot["Team1"],
                                            style: const TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            '${documentSnapshot['Team1Score']}/${documentSnapshot['Team1Wicket']}',
                                            style:
                                                const TextStyle(fontSize: 20.0),
                                          ),
                                          Text(
                                              '(${documentSnapshot["TotalOver1"]}.${documentSnapshot["TotalBalls1"]})')
                                        ],
                                      ),
                                      Image.asset(
                                        'assets/images/vs1-removebg-preview.png',
                                        height: 50,
                                      ),
                                      Column(
                                        children: [
                                          Image.network(
                                            documentSnapshot["Team2logo"],
                                            height: 50,
                                          ),
                                          Text(
                                            documentSnapshot["Team2"],
                                            style: const TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          Text(
                                            '${documentSnapshot['Team2Score']}/${documentSnapshot['Team2Wicket']}',
                                            style:
                                                const TextStyle(fontSize: 20.0),
                                          ),
                                          Text(
                                              '(${documentSnapshot["TotalOver2"]}.${documentSnapshot["TotalBalls2"]})')
                                        ],
                                      ),
                                    ],
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        documentSnapshot["Result"],
                                        style:
                                            const TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });

                  // else {
                  //   return const Center(
                  //     child: CircularProgressIndicator(),
                  //   );
                  // }
                }),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Container(
                height: 70,
                width: 335,
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 2.0,
                          offset: Offset(0.5, 1.0),
                          blurRadius: 2.0)
                    ],
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 17.0),
                  child: Column(
                    children: const [
                      Text(
                        "Developed By: Aditya Deshmukh",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Contact Us : 8530945813aditya@gmail.com",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

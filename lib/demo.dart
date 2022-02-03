import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class FireBase extends StatefulWidget {
  const FireBase({Key? key}) : super(key: key);

  @override
  _FireBaseState createState() => _FireBaseState();
}

class _FireBaseState extends State<FireBase> {
  // final db = FirebaseFirestore.instance.collection("board").snapshots();
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("firebase app"),
      ),
       body: StreamBuilder(
        stream: db.collection("board").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if(snapshot.hasData && snapshot.data != null)
          {
            if (snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> docData = snapshot.data!.docs[index].data();

                  if(docData.isEmpty) {
                    return const Text("Document is empty....");
                  }

                  String name = docData["title"];
                  String phone = docData["email"];
                  return ListTile(
                    title: Text(name),
                    subtitle:  Text(phone),
                  );
                }, 
               
                );
            } else {
              return const LinearProgressIndicator();
            }
          } else {
            return const Center(
              child: LinearProgressIndicator(),
            );
          }
        },
      ),

      // body: StreamBuilder(
      //   stream: db.collection("board").doc("EgMki8FJ0VsMPCg4kJqt").collection("Myname").snapshots(),
      //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
      //     if(snapshot.hasData && snapshot.data != null)
      //     {
      //       if (snapshot.data!.docs.isNotEmpty) {
      //         return ListView.separated(
      //           itemCount: snapshot.data!.docs.length,
      //           itemBuilder: (BuildContext context, int index) {
      //             Map<String, dynamic> docData = snapshot.data!.docs[index].data();

      //             if(docData.isEmpty) {
      //               return const Text("Document is empty....");
      //             }

      //             String name = docData["name"];
      //             String phone = docData["phone"];
      //             return ListTile(
      //               title: Text(name),
      //               subtitle:  Text(phone),
      //             );
      //           }, 
      //           separatorBuilder: (BuildContext context, int index) { 
      //             return const Divider();
      //            },
      //           );
      //       } else {
      //         return const LinearProgressIndicator();
      //       }
      //     } else {
      //       return const Center(
      //         child: LinearProgressIndicator(),
      //       );
      //     }
      //   },
      // ),

      // body: StreamBuilder(
      //   stream:  FirebaseFirestore.instance.collection("board").snapshots(),
      //   builder: (BuildContext context, AsyncSnapshot snapshot) {
      //     if(!snapshot.hasData) return const CircularProgressIndicator() ;

      //     return ListView(
      //       children: snapshot.data.docs.map<Widget>((document) {
      //         return Container(
      //           child: Center(child: Text(document['title'])),
      //         );
      //       }).toList(),
      //     );
      //   },
      //   ),
      // //******************************methode to fetch the data from firebase *********************************
      // // body: StreamBuilder <QuerySnapshot>(
      // //   stream: FirebaseFirestore.instance.collection('board').snapshots(),
      // //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      // //     if (!snapshot.hasData) {
      // //       return const Center(
      // //         child: CircularProgressIndicator(),
      // //       );
      // //     }

      // //     return ListView(
      // //       children: snapshot.data.docs.map<Widget>((document)  {
      // //         return Container(
      // //           child: Center(child: Text(document['title'])),
      // //         );
      // //       }).toList(),
      // //     );
      // //   },
      // // ),
    );
  }
}

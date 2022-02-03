// import 'package:Score_Dekho/admin/admin_match_fixture.dart';
import 'package:flutter/material.dart';

import 'admin_match_fixture.dart';

class AdminMainPage extends StatelessWidget {
  const AdminMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text("Admin panel"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "What you want to do....",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(
              height: 55.0,
            ),
            const Text(
              "For New Match Fixing",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminMatchFixture()));
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurpleAccent,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Match fixture",
                  style: TextStyle(
                    fontSize: 20,
                  ),),
                ),
            ),
            const SizedBox(
              height: 55.0,
            ),
            const Text(
              "For Player Management..",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurpleAccent,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Player managment",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

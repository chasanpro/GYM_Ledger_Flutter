import 'package:animated_button/animated_button.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'profile.dart';

// ignore: must_be_immutable
class user extends StatefulWidget {
  user({Key? key, this.uid}) : super(key: key);
  String? uid;
  @override
  State<user> createState() => _userState();
}

class _userState extends State<user> {
  // final String documentId;
  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;
    double y = MediaQuery.of(context).size.height;

    int rd = 0;
    setState(() {
      rd = 0;
    });

    // ignore: unused_local_variable
    String? ph;

    // ignore: unused_local_variable
    var verification = false;
    CollectionReference users =
        FirebaseFirestore.instance.collection('user-data');

    return MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: 1.0,
        ),
        child: Scaffold(
          floatingActionButton: SizedBox(
            child: AnimatedButton(
              height: 50,
              width: 50,
              color: Colors.deepPurpleAccent,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: const Color(0xFF2D2F41),
          body: FutureBuilder<DocumentSnapshot>(
            future: users.doc("${widget.uid}").get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Material(
                    child: Container(
                        child: Center(child: Text("Something went wrong"))));
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return Material(
                    child: Container(
                        color: Colors.black,
                        child: Center(
                            child: Text(
                          "User Data Deleted❕",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 215, 197),
                              fontWeight: FontWeight.bold),
                        ))));
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                var t1 = data['full_name'].toString();

                var t2 = data['phone_num'].toString();
                ph = t2;
                var diff =
                    DateTime.parse(data['doe']).difference(DateTime.now());
                rd = diff.inDays;

                // ignore: unused_local_variable
                final t3 = t1 + t2;
                List history = [];
                data['payments'].forEach((value) {
                  List<String> result = value.split('-');
                  String pdate = result[0] + result[1] + result[2];
                  DateTime o1 = DateTime.parse(pdate);
                  var month = o1.month;
                  String o3 = o1.year.toString();
                  String o4 = o1.day.toString();
                  // String o5 = result[3];
                  var format = NumberFormat.currency(locale: 'en_IN');
                  String o5 = format.format(int.parse(result[3]));

                  List Months = [
                    "",
                    "January",
                    "February",
                    "March",
                    "April",
                    "May",
                    "June",
                    "July",
                    "August",
                    "September",
                    "October",
                    "November",
                    "December"
                  ];
                  var mon;

                  for (var i = 0; i <= 12; i++) {
                    if (i == month) {
                      mon = Months[i];
                    }
                  }
                  String zz = (o4 + mon + o3);
              
                  history.add(o5 + "  ON  " + zz);
                });

                return Scaffold(
                  backgroundColor: Color.fromARGB(255, 0, 0, 0),
                  body: Material(
                    color: Color.fromARGB(255, 0, 0, 0),
                    child: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: y / 2),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: y / 20,
                                  ),
                                  Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      clipBehavior: Clip.hardEdge,
                                      child: Image.network(
                                        data['image_url'],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    decoration: const BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(24)),
                                    ),
                                    width: x / 2,
                                    height: y / 4,
                                  ),
                                  SizedBox(
                                    height: y / 25,
                                  ),
                                  SizedBox(
                                    height: y / 25,
                                  ),
                                  Container(
                                    color: const Color(0xFF2D2F41),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Word(data['full_name']
                                              .toString()
                                              .toUpperCase()),
                                          Word(data['phone_num']),
                                          // Word(data['doj']),
                                          // Word(data['amount']),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Word("Remaining Days:"),
                                              Word("$rd"),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    height: y * .3,
                                    width: x * .85,
                                  ),
                                  SizedBox(
                                    height: y / 25,
                                  ),
                                  SizedBox(
                                    height: y / 25,
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  SizedBox(
                                    height: y / 20,
                                  ),
                                  Word("PAYMENTS HISTORY"),
                                  SizedBox(
                                    height: y / 25,
                                  ),
                                  Container(
                                    height: history.length * .15 * y,
                                    width: x * .85,
                                    child: ListView.builder(
                                        itemCount: history.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            child: FittedBox(
                                              child: Word(history[
                                                  history.length - index - 1]),
                                            ),
                                            width: x / 3,
                                            height: y / 9.55,
                                            margin: const EdgeInsets.only(
                                                bottom: 32),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 8),
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(24)),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }

              return Text("loading");
            },
          ),
        ));
  }
}

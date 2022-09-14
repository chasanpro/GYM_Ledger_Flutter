import 'package:animated_button/animated_button.dart';

import 'package:dharims_web/month.dart';
import 'package:flutter/material.dart';

import '../panel.dart';
import './user.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class mlist extends StatefulWidget {
  const mlist({Key? key, this.seed}) : super(key: key);
  final seed;

  @override
  _mlistState createState() => _mlistState();
}

class _mlistState extends State<mlist> {
  final refm = FirebaseFirestore.instance.collection("user-data");
  final ref = FirebaseFirestore.instance.collection("PAYMENTS");

  @override
  Widget build(BuildContext context) {
    var total = 0;
    double x = MediaQuery.of(context).size.width;
    double y = MediaQuery.of(context).size.height;

    String payid = widget.seed.trim();

    PageController controller = PageController(initialPage: 1);
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: 1.0,
        ),
        child: PageView(
          physics: BouncingScrollPhysics(),
          controller: controller,
          children: <Widget>[
            Scaffold(
              backgroundColor: Color.fromARGB(255, 0, 0, 0),
              body: Builder(builder: (context) {
                return FutureBuilder<DocumentSnapshot>(
                    future: ref.doc(payid).get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasData && !snapshot.data!.exists) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.pinkAccent,
                        ));
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        snapshot.data?.data().toString;
                        total = 0;
                        data['payments'].forEach((value) {
                          List temp = value.toString().split("-");
                          if (temp[1] != null) {
                            total = total + int.parse(temp[1]);
                          }
                        });
                        var format = NumberFormat.currency(locale: 'en_IN');
                        var money = format.format(total);
                        var sum = 0.0;
                        var networth;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            StreamBuilder(
                                stream: refm.snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasData) {
                                    sum = 0;

                                    snapshot.data?.docs.forEach((element) {
                                      sum = ((int.parse(element['amount']) /
                                              int.parse(element['months'])) +
                                          sum);
                                    });
                                    var format =
                                        NumberFormat.currency(locale: 'en_IN');
                                    networth = format.format(sum);

                                    return Center(
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                width: 2,
                                                color: Color.fromARGB(
                                                    255, 255, 215, 197),
                                              ),
                                            ),
                                            width: x * .8,
                                            height: y * .3,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Center(
                                                  child: Text(
                                                    'Monthly Target',
                                                    style: GoogleFonts.poppins(
                                                      textStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          215,
                                                                          197),
                                                              letterSpacing:
                                                                  .5),
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Center(
                                                  child: Tord(
                                                      networth.toString(), 20),
                                                ),
                                              ],
                                            )));
                                  }

                                  return Center(
                                      child: const CircularProgressIndicator());
                                }),
                            Center(
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        width: 2,
                                        color:
                                            Color.fromARGB(255, 255, 215, 197),
                                      ),
                                    ),
                                    width: x * .8,
                                    height: y * .3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Center(
                                          child: Text(
                                            '${payid}',
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 25, 255, 217),
                                                  letterSpacing: .5),
                                              fontSize: 25,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Word(money.toString()),
                                        ),
                                      ],
                                    ))),
                          ],
                        );
                      } else {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.pinkAccent,
                        ));
                      }
                    });
              }),
            ),
            Material(
              color: Color.fromARGB(255, 0, 0, 0),
              child: Scaffold(
                floatingActionButton: SizedBox(
                  child: AnimatedButton(
                    color: Color.fromARGB(255, 63, 57, 58),
                    height: 50,
                    width: 50,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => month()));
                    },
                    child: Icon(
                      Icons.arrow_left,
                      color: Color.fromARGB(255, 255, 215, 197),
                    ),
                  ),
                ),
                backgroundColor: Color.fromARGB(255, 0, 0, 0),
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Builder(builder: (context) {
                    return FutureBuilder<DocumentSnapshot>(
                      future: ref.doc(payid).get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (snapshot.hasData && !snapshot.data!.exists) {
                          return const Center(
                              child: CircularProgressIndicator(
                            color: Colors.pinkAccent,
                          ));
                        }

                        if (snapshot.connectionState == ConnectionState.done) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          snapshot.data?.data().toString;
                          List mons = [];

                          data['payments'].forEach((value) {
                            List temp = value.toString().split("-");

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
                              if (i == int.parse(temp[3])) {
                                mon = Months[i];
                              }
                            }

                            String tempx =
                                mon.toString() + "  " + temp[4].substring(0, 2);

                            temp[2] = tempx;

                            mons.add(temp);
                          });

                          return ListView.builder(
                              itemCount: mons.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    var uid = mons[mons.length - index - 1][0]
                                            .toString() +
                                        mons[mons.length - index - 1][5];

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => user(
                                                  uid: uid,
                                                )));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        width: 2,
                                        color:
                                            Color.fromARGB(255, 255, 215, 197),
                                      ),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Nord(
                                              mons[mons.length - index - 1][0]),
                                          FittedBox(
                                            child: Text(
                                              mons[mons.length - index - 1][2],
                                              style: GoogleFonts.montserrat(
                                                textStyle: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 74, 243, 255),
                                                    letterSpacing: .5),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "₹${mons[mons.length - index - 1][1]}",
                                            style: GoogleFonts.montserrat(
                                              textStyle: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 74, 255, 83),
                                                  letterSpacing: .2),
                                              fontSize: 25,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    width: x * .65,
                                    height: y / 11,
                                    margin: const EdgeInsets.only(bottom: 32),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                  ),
                                );
                              });
                        }

                        return const Center(child: CircularProgressIndicator());
                      },
                    );
                  }),
                ),
              ),
            ),
          ],
        ));
  }
}

Word(String label) {
  return FittedBox(
    child: Text(
      label.toUpperCase(),
      style: GoogleFonts.montserrat(
        textStyle: const TextStyle(
            color: Color.fromARGB(255, 72, 255, 133), letterSpacing: .5),
        fontSize: 25,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Nord(String label) {
  return FittedBox(
    child: Text(
      label.toUpperCase(),
      style: GoogleFonts.montserrat(
        textStyle: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255), letterSpacing: .5),
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

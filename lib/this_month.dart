import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'Firebase/monthlypay.dart';


class thismonth extends StatefulWidget {
  thismonth({
    Key? key,
  }) : super(key: key);

  @override
  State<thismonth> createState() => _thismonthState();
}

class _thismonthState extends State<thismonth> {
  final refm = FirebaseFirestore.instance.collection("user-data");
  final ref = FirebaseFirestore.instance.collection("PAYMENTS");

  @override
  Widget build(BuildContext context) {
    var total = 0;
    double x = MediaQuery.of(context).size.width;
    double y = MediaQuery.of(context).size.height;
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var month = dateParse.month;
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
    var yr = dateParse.year.toString();
    final String uid = mon + "-" + yr;
    String payid = uid.trim();
return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: 1.0,
      ),
      child: Scaffold(
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
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            sum = 0;

                            snapshot.data?.docs.forEach((element) {
                              sum = ((int.parse(element['amount']) /
                                      int.parse(element['months'])) +
                                  sum);
                            });
                            var format = NumberFormat.currency(locale: 'en_IN');
                            networth = format.format(sum);

                            return Center(
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
                                            'Monthly Target',
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 215, 197),
                                                  letterSpacing: .5),
                                              fontSize: 25,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Word(networth.toString()),
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
                                color: Color.fromARGB(255, 255, 215, 197),
                              ),
                            ),
                            width: x * .8,
                            height: y * .3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Center(
                                  child: Text(
                                    '${payid}',
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 25, 255, 217),
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
                    // SizedBox(
                    //   width: x / 2,
                    //   height: y / 3,
                    //   child: LiquidCircularProgressIndicator(
                    //     value: int.parse(payid)/networth, // Defaults to 0.5.
                    //     valueColor: AlwaysStoppedAnimation(Colors
                    //         .pink), // Defaults to the current Theme's accentColor.
                    //     backgroundColor: Color.fromARGB(255, 0, 0,
                    //         0), // Defaults to the current Theme's backgroundColor.
                    //     borderColor: Colors.red,
                    //     borderWidth: 5.0,
                    //     direction: Axis
                    //         .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                    //     center: Text("Loading..."),
                    //   ),
                    // ),
                  ],
                );
              }
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.pinkAccent,
              ));
            });
      }),)
    );
  }
}

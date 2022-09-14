import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class dash extends StatefulWidget {
  const dash({Key? key}) : super(key: key);

  @override
  _dashState createState() => _dashState();
}

class _dashState extends State<dash> {
  final ref = FirebaseFirestore.instance.collection("user-data");

  @override
  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;
    double y = MediaQuery.of(context).size.height;

    var sum = 0.0;

    return MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: 1.0,
        ),
        child: Material(
          color: Color(0xFF2D2F41),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Ford("Networth :", 25),
                        StreamBuilder(
                            stream: ref.snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                snapshot.data?.docs.forEach((element) {
                                  sum = ((int.parse(element['amount']) /
                                          int.parse(element['months'])) +
                                      sum);
                                });
                                return Word("$sum", 25);
                              }
                              return CircularProgressIndicator.adaptive();
                            }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Ford("Number of Customers :", 25),
                        StreamBuilder(
                            stream: ref.snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                final Count = snapshot.data?.docs.length;

                                return Word("$Count", 25);
                              }
                              return CircularProgressIndicator.adaptive();
                            }),
                      ],
                    ),
                  ],
                ),
                color: Color(0xFF2D2F41),
                height: y / 3,
                width: x * .85,
              ),
            ],
          ),
        ));
  }

  Word(String label, double sz) {
    return Text(
      label,
      style: GoogleFonts.montserrat(
        textStyle: const TextStyle(
            color: Color.fromARGB(255, 64, 251, 95), letterSpacing: .5),
        fontSize: sz,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Ford(String label, double sz) {
    return Text(
      label,
      style: GoogleFonts.montserrat(
        textStyle: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255), letterSpacing: .5),
        fontSize: sz,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

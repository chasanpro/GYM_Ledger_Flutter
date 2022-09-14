import 'package:animated_button/animated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dharims_web/Dashboard.dart';
import 'Firebase/monthlypay.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class month extends StatelessWidget {
  // final String documentId;

  // month(this.documentId);

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;
    double y = MediaQuery.of(context).size.height;

    var sea = [Color(0xFF61A3FE), Color(0xFF63FFD5)];

    CollectionReference users = FirebaseFirestore.instance.collection('Months');

return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: 1.0,
      ),
      child: Material(
      color: Color.fromARGB(255, 0, 0, 0),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Scaffold(
          floatingActionButton: SizedBox(
            child: AnimatedButton(
              color: Color.fromARGB(255, 241, 55, 101),
              height: 50,
              width: 50,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => dashboard()));
              },
              child: Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          body: FutureBuilder<DocumentSnapshot>(
            future: users.doc("2022").get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                snapshot.data?.data().toString;
                List mons = [];
                data['months'].forEach((value) {
                  mons.add(value);
                });

                return ListView.builder(
                    itemCount: mons.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => mlist(
                                        seed: mons[mons.length - index - 1],
                                      )));
                        },
                        child: Container(
                          child: Center(
                            child: Word(mons[mons.length - index - 1]),
                          ),
                          width: x * .65,
                          height: y / 9.55,
                          margin: const EdgeInsets.only(bottom: 32),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: sea,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(24)),
                          ),
                        ),
                      );
                    });
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),)
    );
  }
}

Word(String label) {
  return Text(
    label,
    style: GoogleFonts.montserrat(
      textStyle: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0), letterSpacing: .5),
      fontSize: 25,
      fontWeight: FontWeight.w600,
    ),
  );
}

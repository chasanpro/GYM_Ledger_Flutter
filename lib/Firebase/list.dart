import 'package:animated_button/animated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dharims_web/Dashboard.dart';
import 'package:dharims_web/Firebase/profile.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../panel.dart';

class delete extends StatefulWidget {
  const delete({Key? key}) : super(key: key);
  @override
  _deleteState createState() => _deleteState();
}

DateTime now =
    DateTime.parse(DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()));

class _deleteState extends State<delete> {
  final ref = FirebaseFirestore.instance.collection("user-data");
  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;
    double y = MediaQuery.of(context).size.height;
    var sunset = [Color(0xFFFE6197), Color(0xFFFFB463)];


    return MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: 1.0,
        ),
        child: Material(
          color: Color.fromARGB(255, 0, 0, 0),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Scaffold(
              floatingActionButton: SizedBox(
                child: AnimatedButton(
                  color: Color.fromARGB(255, 63, 57, 58),
                  height: 50,
                  width: 50,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => dashboard()));
                  },
                  child: Icon(
                    Icons.home,
                    color: Color.fromARGB(255, 255, 215, 197),
                  ),
                ),
              ),
              backgroundColor: Color.fromARGB(255, 0, 0, 0),
              body: StreamBuilder(
                  stream: ref.snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            DateTime dt2 = DateTime.parse(
                                snapshot.data?.docs[index]['doe']);
                            var diff = dt2.difference(now);
                            int rd = diff.inDays;

                            return InkWell(
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor:
                                          Color.fromARGB(255, 0, 0, 0),
                                      title: Ford('Remove Permanantly', 20),
                                      content: Ford('Remove from  ☁️', 15),
                                      actions: [
                                        Center(
                                          child: MaterialButton(
                                            height: y / 15,
                                            color: Color.fromARGB(
                                                255, 255, 215, 197),
                                            onPressed: () {
                                              var deleteid =
                                                  snapshot.data?.docs[index]
                                                          ['full_name'] +
                                                      snapshot.data?.docs[index]
                                                          ['phone_num'];

                                              Future<void> deleteUser() {
                                                return ref
                                                    .doc(deleteid)
                                                    .delete()
                                                    .then((value) =>
                                                        print("User Deleted"))
                                                    .catchError((error) => print(
                                                        "Failed to delete user: $error"));
                                              }

                                              deleteUser();
                                            },
                                            child: FittedBox(
                                              child: Text(
                                                'DELETE',
                                                style: GoogleFonts.montserrat(
                                                  textStyle: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      letterSpacing: .5),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => profile(
                                            ghost: snapshot.data?.docs[index],
                                            days: rd.toString())));
                              },
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      clipBehavior: Clip.hardEdge,
                                      child: Image.network(
                                        snapshot.data?.docs[index]['image_url'],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Word(snapshot.data?.docs[index]
                                            ['full_name']),
                                        Word(snapshot.data?.docs[index]
                                            ['phone_num']),
                                        Word('DAYS LEFT:: $rd'),
                                      ],
                                    )
                                  ],
                                ),
                                width: x * .8,
                                height: y / 4.55,
                                margin: const EdgeInsets.only(bottom: 32),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: sunset,
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(24)),
                                ),
                              ),
                            );
                          });
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ),
        ));
  }
}

Word(String label) {
  return Text(
    label,
    style: GoogleFonts.montserrat(
      textStyle: const TextStyle(color: Colors.black, letterSpacing: .5),
      fontSize: 15,
      fontWeight: FontWeight.w600,
    ),
  );
}

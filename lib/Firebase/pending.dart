import 'package:animated_button/animated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '/Firebase/profile.dart';
import '/sms.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';

// ignore: must_be_immutable
class pending extends StatefulWidget {
  int limit, min;

  pending({Key? key, required this.limit, required this.min}) : super(key: key);

  @override
  _pendingState createState() => _pendingState();
}

DateTime now =
    DateTime.parse(DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now()));

class _pendingState extends State<pending> {
  List pendingList = [];

  final ref = FirebaseFirestore.instance.collection("user-data");
  @override
  Widget build(BuildContext context) {
    pendingList = [];

    double x = MediaQuery.of(context).size.width;
    double y = MediaQuery.of(context).size.height;

    var fire = [Color(0xFFFF5DCD), Color(0xFFFF8484)];

    var yc = y / 4.55;
    var xc = x * .395;
return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: 1.0,
      ),
      child:Material(
      color: Color.fromARGB(255, 0, 0, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            child: StreamBuilder(
                stream: ref.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    pendingList = [];
                    snapshot.data?.docs.forEach((element) {
              
                      if (renewdays(element['doe']) <= widget.limit &&
                          renewdays(element['doe']) >= widget.min) {
                        pendingList.add(element);
                      }
                    });
                    pendingList.toSet().toList();
                    return ListView.builder(
                        itemCount: pendingList.length,
                        itemBuilder: (context, index) {
                          int rd =
                              renewdays(pendingList[index]['doe'].toString());
                          return InkWell(
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Expanded(
                                    child: AlertDialog(
                                      backgroundColor: Color(0xFF2D2F41),
                                      title: Word('Remove Permanantly'),
                                      content: Word('Remove from  ☁️'),
                                      actions: [
                                        Center(
                                          child: AnimatedButton(
                                            width: x / 7,
                                            height: y / 15,
                                            shape: BoxShape.rectangle,
                                            color: const Color.fromARGB(
                                                255, 247, 153, 223),
                                            onPressed: () {},
                                            child: FittedBox(
                                              child: Text(
                                                'Proceed',
                                                style: GoogleFonts.montserrat(
                                                  textStyle: const TextStyle(
                                                      color: Colors.black,
                                                      letterSpacing: .5),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => profile(
                                          ghost: pendingList[index],
                                          days: rd.toString())));
                            },
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          clipBehavior: Clip.hardEdge,
                                          child: Image.network(
                                            pendingList[index]['image_url'],
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        decoration: const BoxDecoration(
                                          color: Colors.blueAccent,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(24)),
                                        ),
                                        width: xc,
                                        height: yc,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Word(pendingList[index]['full_name']),
                                          Word(pendingList[index]['phone_num']),
                                          Word('DAYS LEFT:: $rd'),
                                         IconButton(
                                              icon: Icon(
                                                Icons.sms,
                                              ),
                                              iconSize: 25,
                                              color: Color.fromARGB(
                                                  255, 122, 102, 238),
                                              onPressed: () {
                                                sms.smsAlert(
                                                    pendingList[index]
                                                        ['phone_num'],
                                                    pendingList[index]
                                                        ['full_name'],
                                                    DateTime.parse(
                                                        pendingList[index]
                                                            ['doe']),
                                                    rd);
                                              },
                                            ),
                                        
                                        ],
                                      )
                                    ],
                                  ),
                                  width: x * .99,
                                  height: y / 5.55,
                                  margin: const EdgeInsets.only(bottom: 32),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: fire,
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(24)),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ),
      ),)
    );
  }

  int renewdays(String doe) {
    int rd = 0;
    DateTime dt2 = DateTime.parse(doe);
    var diff = dt2.difference(now);
    rd = diff.inDays;

    return rd;
  }
}

import 'package:animated_button/animated_button.dart';
import 'package:dharims_web/Firebase/notifnav.dart';
import 'package:dharims_web/logout.dart';
import 'package:flutter/material.dart';

import 'Firebase/drw.dart';
import 'Firebase/search.dart';

import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Firebase/list.dart';
import 'Firebase/create.dart';

import 'month.dart';

import 'package:google_fonts/google_fonts.dart';

class panel extends StatefulWidget {
  const panel({Key? key}) : super(key: key);

  @override
  _panelState createState() => _panelState();
}

class _panelState extends State<panel> {
  get bgclr => null;
  final ref = FirebaseFirestore.instance.collection("user-data");
  var sum = 0.0;

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;
    double y = MediaQuery.of(context).size.height;
    final now = DateTime.now();
    final df = DateFormat.yMMMMEEEEd();
    // ignore: unused_element
    DateTime weekdayOf(DateTime time, int weekday) =>
        time.add(Duration(days: weekday - time.weekday));
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: 1.0,
        ),
        child: Material(
          child: Scaffold(
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      height: y / 30,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          CircleAvatar(
                            child: Image.network(
                                "https://firebasestorage.googleapis.com/v0/b/dharims-886b0.appspot.com/o/Avatars%2Flogo.jpg?alt=media&token=fd30aa4e-0fa7-4b1f-9534-81fb7fc5bd17"),
                            backgroundColor: Color.fromARGB(255, 255, 215, 197),
                            radius: 30,
                            //Text
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Spacer(),
                              Text(
                                'Welcome Back Mahesh ',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    color: Color.fromARGB(255, 255, 215, 197),
                                  ),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "${df.format(now)}",
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                    color: Color.fromARGB(255, 255, 215, 197),
                                  ),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                          Spacer(),
                          AnimatedButton(
                            color: Color.fromARGB(255, 31, 30, 46),
                            height: 50,
                            width: 50,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => logout()));
                            },
                            child: Icon(
                              Icons.settings,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      height: y / 8,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Ford("Monthly Pay:", 25),
                              StreamBuilder(
                                  stream: ref.snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasData) {
                                      sum = 0;

                                      snapshot.data?.docs.forEach((element) {
                                        sum = ((int.parse(element['amount']) /
                                                int.parse(element['months'])) +
                                            sum);
                                      });
                                      var format = NumberFormat.currency(
                                          locale: 'en_IN');
                                      var money = format.format(sum);

                                      return Tord("${money}", 20);
                                    }
                                    return Center(
                                        child:
                                            const CircularProgressIndicator());
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

                                      return Tord("$Count", 20);
                                    }
                                    return const CircularProgressIndicator
                                        .adaptive();
                                  }),
                            ],
                          ),
                        ],
                      ),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      height: y / 6,
                      width: x * .95,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: Color.fromARGB(255, 31, 30, 46),

                              // Red border with the width is equal to 5
                              border: Border.all(
                                  width: 5,
                                  color: Color.fromARGB(255, 31, 30, 46))),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const create()));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Center(
                                    child: Icon(
                                  Icons.person_add,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  size: 30,
                                )),
                                Ford("Add user", 20),
                              ],
                            ),
                          ),
                          height: y / 6,
                          width: x / 2.8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: Color.fromARGB(255, 31, 30, 46),
                              border: Border.all(
                                  width: 5,
                                  color: Color.fromARGB(255, 31, 30, 46))),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const delete()));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Center(
                                    child: Icon(
                                  Icons.list_alt,
                                  color: Color.fromARGB(255, 255, 103, 103),
                                  size: 30,
                                )),
                                Ford("User List", 20),
                              ],
                            ),
                          ),
                          height: y / 6,
                          width: x / 2.8,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: y / 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: Color.fromARGB(255, 31, 30, 46),

                              // Red border with the width is equal to 5
                              border: Border.all(
                                  width: 5,
                                  color: Color.fromARGB(255, 31, 30, 46))),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => month()));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Center(
                                    child: Icon(
                                  Icons.calendar_month,
                                  color: Color.fromARGB(255, 92, 252, 255),
                                  size: 30,
                                )),
                                Ford("Mothly Pay", 20),
                              ],
                            ),
                          ),
                          height: y / 6,
                          width: x / 2.8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: Color.fromARGB(255, 31, 30, 46),
                              border: Border.all(
                                  width: 5,
                                  color: Color.fromARGB(255, 31, 30, 46))),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => search()));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Center(
                                    child: Icon(
                                  Icons.search,
                                  color: Color.fromARGB(255, 255, 52, 133),
                                  size: 30,
                                )),
                                Ford("Search user", 20),
                              ],
                            ),
                          ),
                          height: y / 6,
                          width: x / 2.8,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: y / 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: Color.fromARGB(255, 31, 30, 46),

                              // Red border with the width is equal to 5
                              border: Border.all(
                                  width: 5,
                                  color: Color.fromARGB(255, 31, 30, 46))),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => drw()));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Center(
                                    child: Icon(
                                  Icons.calendar_month,
                                  color: Color.fromARGB(255, 255, 244, 92),
                                  size: 30,
                                )),
                                Ford("Pay in Range", 20),
                              ],
                            ),
                          ),
                          height: y / 6,
                          width: x / 2.8,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: Color.fromARGB(255, 31, 30, 46),

                              // Red border with the width is equal to 5
                              border: Border.all(
                                  width: 5,
                                  color: Color.fromARGB(255, 31, 30, 46))),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyWidget()));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Center(
                                    child: Icon(
                                  Icons.notification_add_sharp,
                                  color: Color.fromARGB(255, 95, 218, 171),
                                  size: 30,
                                )),
                                Ford("Remainder", 20),
                              ],
                            ),
                          ),
                          height: y / 6,
                          width: x / 2.8,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

Word(String label) {
  return Text(
    '$label',
    style: GoogleFonts.montserrat(
      textStyle: const TextStyle(color: Colors.black, letterSpacing: .5),
      fontSize: 25,
      fontWeight: FontWeight.w600,
    ),
  );
}

Tord(String label, double sz) {
  return Text(
    label,
    style: GoogleFonts.montserrat(
      textStyle: const TextStyle(
          color: Color.fromARGB(255, 0, 255, 42), letterSpacing: .5),
      fontSize: sz,
      fontWeight: FontWeight.w600,
    ),
  );
}

Ford(String label, double sz) {
  // var format = NumberFormat.currency(locale: 'en_IN');
  // final money = format.format(label);
  return Text(
    label,
    style: GoogleFonts.montserrat(
      textStyle: const TextStyle(
        color: Color.fromARGB(255, 255, 215, 197),
      ),
      fontSize: sz,
      fontWeight: FontWeight.w400,
    ),
  );
}

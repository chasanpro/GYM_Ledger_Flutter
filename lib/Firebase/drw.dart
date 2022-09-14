import 'package:animated_button/animated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dharims_web/Dashboard.dart';
import 'package:dharims_web/panel.dart';


import '/Firebase/user.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'monthlypay.dart';

class drw extends StatefulWidget {
  const drw({Key? key}) : super(key: key);

  @override
  State<drw> createState() => _drwState();
}

class _drwState extends State<drw> {
  List<dynamic> mons = [];
  int total = 0;
  var qry = <String>{};
  late DateTime dt1, dt2;
  var ms, me;
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

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;
    double y = MediaQuery.of(context).size.height;
return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: 1.0,
      ),
      child: Material(
      color: Colors.black,
      child: Scaffold(
        floatingActionButton: SizedBox(
          child: AnimatedButton(
            color: Color.fromARGB(255, 49, 42, 44),
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              color: Color.fromARGB(255, 0, 0, 0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: y / 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Center(
                            child: SfDateRangePicker(
                              backgroundColor:
                                  Color.fromARGB(210, 255, 255, 255),
                              selectionColor: Color.fromARGB(210, 249, 77, 77),
                              onSelectionChanged: _onSelectionChanged,
                              todayHighlightColor:
                                  Color.fromARGB(255, 134, 53, 255),
                              selectionMode: DateRangePickerSelectionMode.range,
                              rangeSelectionColor:
                                  Color.fromARGB(210, 255, 213, 63),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(210, 0, 0, 0),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          height: y / 3,
                          width: x * .85,
                        ),
                        SizedBox(
                          height: y / 16,
                        ),
                        Tord("${total}", 25),
                        SizedBox(
                          height: y / 16,
                        ),
                        AnimatedButton(
                          height: 50,
                          width: 150,
                          color: Color.fromARGB(255, 64, 64, 72),
                          onPressed: () {
                            setState(() {
                              mons;
                              print(mons);
                            });
                          },
                          child: Text(
                            'CALCULATE',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 255, 215, 197),
                                  letterSpacing: .5),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: y / 16,
                        ),
                      ],
                    ),
                    if (mons.length > 0)
                      SingleChildScrollView(
                        child: Container(
                          width: x * .85,
                          height: y * .79,
                          child: ListView.builder(
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
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Nord(mons[mons.length - index - 1][0]),
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
                                          mons[mons.length - index - 1][1],
                                          style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 74, 255, 83),
                                                letterSpacing: .5),
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  // height: y / 11,
                                  height: y / 10,
                                  width: x * .85,
                                  margin: const EdgeInsets.only(bottom: 22),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                      color: Color.fromARGB(255, 255, 215, 197),
                                    ),
                                    color: Color.fromARGB(195, 0, 0, 0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    if (mons.length == 0)
                      Center(
                        child: Text(
                          'Selects Two Dates',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                color: Color.fromARGB(211, 255, 255, 255),
                                letterSpacing: .5),
                            fontSize: 35,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),)
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value.endDate != null) {
      setState(() {
        dt1 = args.value.startDate!;
        dt2 = args.value.endDate!;
        total = 0;

        monthextact();
      });
    }
  }

  void monthextact() {
    void check(DateTime dt1, dt2) {
      if (dt2 == null) return;
      var dateParse = dt1;

      var month = dateParse.month;
      ms = month;
      dateParse = dt2;
      month = dateParse.month;
      me = month;
      void purge(int z) {
        var mon;

        for (var i = 0; i <= 12; i++) {
          if (i == z) {
            mon = Months[i];
          }
        }
        var yr = dateParse.year.toString();
        final String uid = mon.toString() + "-" + yr.toString();

        qry.add(uid);
      }

      for (var z = ms; z <= me; z++) {
        purge(z);
      }
    }

    check(dt1, dt2);
    print(qry);

    transactions(qry);
  }

  transactions(Set<String> qry) async {
    mons.clear();

    final ref = FirebaseFirestore.instance.collection("PAYMENTS");
    for (var t in qry) {
 
      ref.doc(t).get().then((DocumentSnapshot documentSnapshot) async {
        if (documentSnapshot.exists) {
          for (var p in documentSnapshot.get("payments")) {
            List temp = p.toString().split("-");

            DateTime cd =
                DateTime.parse(temp[2] + "-" + temp[3] + "-" + temp[4]);
            if (cd.isBefore(dt2) & cd.isAfter(dt1)) {
              var mon;
              total = total + int.parse(temp[1]);
              for (var i = 0; i <= 12; i++) {
                if (i == int.parse(temp[3])) {
                  mon = Months[i];
                }
              }
              String tempx = mon.toString() + "  " + temp[4].substring(0, 2);

              temp[2] = tempx;

              mons.add(temp);
            }
          }
        }
      });
    }

    return mons;
  }
}

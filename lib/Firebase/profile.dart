import 'package:animated_button/animated_button.dart';

import 'package:dharims_web/Dashboard.dart';
import '/Firebase/fire_up_load.dart';
import 'package:intl/intl.dart';
import '/sms.dart';
import 'package:flutter/material.dart';
import 'parser.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

// ignore: must_be_immutable
class profile extends StatefulWidget {
  profile({Key? key, this.days, this.ghost}) : super(key: key);
  final ghost;
  late var days;
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  String? name, ph, comment, pic, m, a, doe;

  var p = 0;
  var verification = false;
  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;

    double y = MediaQuery.of(context).size.height;
    var yc = y / 4.55;
    var xc = x * .395;
    // ignore: unused_local_variable
    final df = DateFormat.yMMMMEEEEd();
    final iskeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    var t1 = widget.ghost['full_name'].toString();
    name = t1;

    var t2 = widget.ghost['phone_num'].toString();
    ph = t2;

    final t3 = t1 + t2;
    List history = [];

    widget.ghost['payments'].forEach((value) {
      List<String> result = value.split('-');
      String pdate = result[0] + result[1] + result[2];
      DateTime o1 = DateTime.parse(pdate);
      var month = o1.month;
      String o3 = o1.year.toString();
      String o4 = o1.day.toString();
      String o5 = result[3];

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

      history.add("₹" + o5 + "-" + zz);
   
    });

    return MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: 1.0,
        ),
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          floatingActionButton: SizedBox(
            child: AnimatedButton(
              color: Color.fromARGB(255, 39, 35, 36),
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
          body: Material(
            color: Color.fromARGB(255, 0, 0, 0),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: y / 2),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        height: y / 20,
                      ),
                      Column(
                        children: [
                          if (!iskeyboard)
                            Column(
                              children: [
                                Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    clipBehavior: Clip.hardEdge,
                                    child: Image.network(
                                      widget.ghost['image_url'],
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  decoration: const BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(24)),
                                  ),
                                  width: xc,
                                  height: yc,
                                )
                              ],
                            )
                        ],
                      ),
                      SizedBox(
                        height: y / 25,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromARGB(255, 31, 30, 46),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Labeltag('Name'),
                                  Labeltag('Phone number'),
                                  Labeltag('Date of Joining'),
                                  Labeltag('Current Plan')
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Word(widget.ghost['full_name']
                                      .toString()
                                      .toUpperCase()),
                                  Word(widget.ghost['phone_num']),
                                  Word(parser(widget.ghost['doj']).toString()),
                                  Word('₹${widget.ghost['amount']}')
                                ],
                              )
                            ],
                          ),
                        ),
                        height: y / 6.5,
                        width: x * .85,
                      ),
                      SizedBox(
                        height: y / 25,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromARGB(255, 31, 30, 46),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Word("Remaining Days:"),
                              Word(widget.days),
                              AnimatedButton(
                                width: x / 7,
                                height: y / 15,
                                shape: BoxShape.rectangle,
                                color: const Color.fromARGB(255, 247, 153, 223),
                                onPressed: () {
                                  _refresh();
                                },
                                child: FittedBox(
                                  child: Text(
                                    'Reset',
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
                            ],
                          ),
                        ),
                        height: y / 8.5,
                        width: x * .85,
                      ),
                      SizedBox(
                        height: y / 25,
                      ),
                      Container(
                        height: history.length * .15 * y,
                        width: x * .8,
                        child: ListView.builder(
                            itemCount: history.length,
                            itemBuilder: (context, index) {
                              return Container(
                                child: Center(
                                  child: Textbox(
                                      history[history.length - index - 1]),
                                ),
                                width: x * .65,
                                height: y / 9.55,
                                margin: const EdgeInsets.only(bottom: 32),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: Color.fromARGB(255, 255, 215, 197),
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24)),
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: y / 25,
                      ),
                      SizedBox(
                        height: y / 25,
                      ),
                      SizedBox(
                        height: y / 25,
                      ),
                      Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextField(
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                onChanged: (value) {
                                  p = int.parse(value);
                                  var increment =
                                      int.parse(widget.days) + (p * 30);
                                  var futurex = DateTime.now()
                                      .add(Duration(days: increment));
                                  doe = futurex.toString();
                                },
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                maxLength: 2,
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Number of Months'),
                              ),
                              TextField(
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                onChanged: (value) {
                                  a = value;
                                },
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                maxLength: 5,
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                    iconColor: Colors.deepOrangeAccent,
                                    border: InputBorder.none,
                                    hintText: 'Amount'),
                              ),
                            ],
                          ),
                        ),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        height: y / 5.5,
                        width: x * .85,
                      ),
                      SizedBox(
                        height: y / 25,
                      ),
                      SizedBox(
                        height: y / 25,
                      ),
                      Container(
                        child: InkWell(
                          onTap: () {
                            String uid = t3;

                            a = a.toString();
                            m = p.toString();

                            FirebaseApi.updataData(
                                uid, m!, a!, doe!, name!, ph!);
                            sms.smsupgrade(ph!, name, DateTime.parse(doe!));

                            showTopSnackBar(
                              context,
                              const CustomSnackBar.success(
                                backgroundColor: const Color(0xFF2D2F41),
                                message: "User Sucessfully Upgraded",
                              ),
                            );

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => dashboard()));
                          },
                          child: Center(
                            child: Text(
                              'UPGRADE',
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    color: Colors.black, letterSpacing: .5),
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        width: x / 4,
                        decoration: const BoxDecoration(
                            color: const Color.fromARGB(255, 109, 255, 165),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        height: x / 8,
                      ),
                      SizedBox(
                        height: y / 25,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  void _refresh() {
    setState(() {
      widget.days = "0";
    });
  }
}

Word(String label) {
  return Text(
    '$label',
    style: GoogleFonts.montserrat(
      textStyle: const TextStyle(
          color: Color.fromARGB(255, 255, 215, 197), letterSpacing: .2),
      fontSize: 15,
      fontWeight: FontWeight.w600,
    ),
  );
}

Textbox(String label) {
  return Text(
    '$label',
    style: GoogleFonts.montserrat(
      textStyle: const TextStyle(
          color: Color.fromARGB(255, 255, 215, 197), letterSpacing: 3),
      fontSize: 15,
      fontWeight: FontWeight.w600,
    ),
  );
}

Labeltag(String label) {
  return Text(
    '$label',
    style: GoogleFonts.montserrat(
      textStyle: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255), letterSpacing: 3),
      fontSize: 15,
      fontWeight: FontWeight.w600,
    ),
  );
}

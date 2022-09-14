import 'package:animated_button/animated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dharims_web/Dashboard.dart';
import 'package:flutter_sms/flutter_sms.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class holiday extends StatefulWidget {
  const holiday({Key? key}) : super(key: key);
  @override
  _holidayState createState() => _holidayState();
}

var now = DateTime.now();
String? reason;

final df = DateFormat.yMMMMEEEEd();
final ref = FirebaseFirestore.instance.collection("user-data");
List<String> buddyList = [];
DateTime weekdayOf(DateTime time, int weekday) =>
    time.add(Duration(days: weekday - time.weekday));

class _holidayState extends State<holiday> {
  final ref = FirebaseFirestore.instance.collection("user-data");

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;
    double y = MediaQuery.of(context).size.height;

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
              body: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 2,
                          color: Color.fromARGB(255, 255, 215, 197),
                        ),
                      ),
                      height: y / 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Center(
                            child: Word(
                                "Hey Gym-buddy,                                                        "),
                          ),
                          Center(
                            child: Word("on behalf of "),
                          ),
                          Container(
                            width: x / 1.5,
                            color: Colors.white,
                            child: TextField(
                              textAlign: TextAlign.center,
                              onChanged: ((value) {
                                // ignore: unused_local_variable
                                reason = value;
                              }),
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    letterSpacing: .5),
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: const InputDecoration(
                                  hoverColor: Color.fromARGB(255, 0, 0, 0),
                                  fillColor: Color.fromARGB(255, 0, 0, 0),
                                  border: InputBorder.none,
                                  hintText: 'Enter the Reason'),
                            ),
                          ),
                          Text(
                            "${df.format(now)} ",
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Color.fromARGB(255, 255, 215, 197),
                              ),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "is declared as a holiday",
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Color.fromARGB(255, 255, 215, 197),
                              ),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Center(
                            child: Word("-Dharims💪Fitnesszone"),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        child: SfDateRangePicker(
                          onSelectionChanged: _onSelectionChanged,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.blueGrey[100],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        height: y / 4,
                        width: x * .85,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        List<String> recepients = [];

                        final message =
                            "Hey Gym-buddy on behalf of $reason ${df.format(now)} is declared as a holiday -Dharims💪Fitnesszone";

                        Future<void> bulksms(String message) async {
                          try {
                            ref.get().then((QuerySnapshot querySnapshot) {
                              querySnapshot.docs.forEach((doc) {
                                recepients.add(doc["phone_num"].toString());
                              });
                            }).whenComplete(() async {
                              print("😎");
                              print(recepients);
                              await sendSMS(
                                message: message,
                                recipients: recepients,
                              );
                            });

                            //ignore: unused_local_variable

                          } catch (error) {
                            print(error.toString());
                          }
                        }

                        bulksms(message);
                      },
                      child: Container(
                        width: x / 4,
                        height: x / 7,
                        child: Center(
                          child: Text(
                            "Bulk SMS",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 215, 197),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      now = args.value;
    });
  }
}

Word(String label) {
  return Text(
    label,
    style: GoogleFonts.montserrat(
      textStyle: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255), letterSpacing: .5),
      fontSize: 15,
      fontWeight: FontWeight.w600,
    ),
  );
}

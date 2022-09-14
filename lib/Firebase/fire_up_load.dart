import 'dart:core';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

double y3 = 0, nw = 0, sum = 0;

class FirebaseApi {
  static UploadTask? uploadFile(String destination, File file) {
    try {
      final fire = FirebaseStorage.instance.ref(destination);
      return fire.putFile(file);
    } on FirebaseException {
      return null;
    }
  }

  static Future<String?> networth() async {
    try {
      FirebaseFirestore.instance
          .collection('user-data')
          .get()
          .then((QuerySnapshot querySnapshot) {
        sum = 0;
        for (var doc in querySnapshot.docs) {
          int y1 = int.parse(doc["amount"]!);
          int y2 = int.parse(doc["months"]!);

          y3 = (y1 / y2);

          sum = sum + (y3);
        }
      });

      return "$sum";
    } on FirebaseException {
      return "😭😭😭😭😭";
    }
  }

  static Future<String> upget(String destination, File file) async {
    try {
      var fire = await FirebaseStorage.instance
          .ref()
          .child(destination)
          .putFile(file)
          .whenComplete(() => null);
      var durl = await fire.ref.getDownloadURL();
      return durl;
    } on FirebaseException {
      return "Something went wrong ";
    }
  }

  static String? write(String name, String ph, String pic, String dop,
      String doe, String doj, String m, String a) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('user-data');
    String id = name + ph;
    var x = DateTime.now();

    trace(name, ph, a);

    try {
      users
          .doc(id)
          .set({
            'full_name': name,
            'phone_num': ph,
            'image_url': pic,
            'doj': doj,
            'dop': dop,
            'doe': doe,
            'months': m,
            'amount': a,
            'payments': FieldValue.arrayUnion(["$x-$a-"]),
          })
          .whenComplete(() => print("create sucess"))
          .onError((error, stackTrace) => print("Got some Problem at Create"));

      return "Fine!";
    } on FirebaseException {
      return "Something went Wrong ";
    }
  }

  static String? trace(String name, String ph, String a) {
    CollectionReference ref = FirebaseFirestore.instance.collection('PAYMENTS');

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

    var d1 = DateTime.parse(date);

    try {
      month_year(uid);
      ref
          .doc(uid)
          .update({
            'payments': FieldValue.arrayUnion(["$name-$a-$d1-$ph"]),
          })
          .then((value) => print("payment update trace failed"))
          .onError((error, stackTrace) => tracenew(name, ph, a));
      return "Fine!";
    } on FirebaseException catch (e) {
      print("😶‍🌫️😶‍🌫️😶‍🌫️😶‍🌫️😶‍🌫️😶‍🌫️😶‍🌫️😶‍🌫️😶‍🌫️ $e");

      return "Something went Wrong ";
    }
  }

  static String? tracenew(String name, String ph, String a) {
    CollectionReference ref = FirebaseFirestore.instance.collection('PAYMENTS');

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

    var d1 = DateTime.parse(date);
    month_year(uid);
    try {
      ref
          .doc(uid)
          .set({
            'payments': FieldValue.arrayUnion(["$name-$a-$d1-$ph"]),
          })
          .then((value) => print("new payment trace Failed"))
          .onError((error, stackTrace) => print(
              "😶‍🌫️😶‍🌫️😶‍🌫️😶‍🌫️😶‍🌫️😶‍🌫️😶‍🌫️😶‍🌫️😶‍🌫️ $error"));
      return "Fine!";
    } on FirebaseException catch (e) {
      print("😶‍🌫️😶‍🌫️😶‍🌫️😶‍🌫️😶‍🌫️😶‍🌫️😶‍🌫️😶‍🌫️😶‍🌫️ $e");
      return "Something went Wrong ";
    }
  }

  static String? month_year(String mid) {
    CollectionReference users = FirebaseFirestore.instance.collection('Months');

    try {
      users
          .doc("2022")
          .update({
            'months': FieldValue.arrayUnion([mid])
          })
          .then((value) => print("Ohio"))
          .onError((error, stackTrace) => print("Got some Problem"));
      return "Fine!";
    } on FirebaseException {
      return "Something went Wrong ";
    }
  }

  static Future<String> updataData(String uid, String m, String a, String doe,
      String name, String ph) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection('user-data');
    var x = DateTime.now();

    try {
      trace(name, ph, a);
      users
          .doc(uid)
          .update({
            'amount': a,
            'months': m,
            'doe': doe,
            'payments': FieldValue.arrayUnion(["$x-$a-$ph"]),
          })
          .then((value) =>
              {print("User Updated"), print(a), print(DateTime.now())})
          // ignore: invalid_return_type_for_catch_error
          .catchError((error) => print("Failed to update user: $error"));
      return " DONE";
    } on FirebaseException {
      return " Ohio";
    }
  }
}

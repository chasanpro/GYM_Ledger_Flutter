import 'package:animated_button/animated_button.dart';
import 'package:dharims_web/Dashboard.dart';

import 'package:flutter/material.dart';

import 'package:random_avatar/random_avatar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '/sms.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'dart:io';

import 'package:intl/intl.dart';

import 'package:file_picker/file_picker.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:image_picker/image_picker.dart';

import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'fire_up_load.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

class create extends StatefulWidget {
  const create({Key? key}) : super(key: key);

  State<create> creacreateate() => _createState();

  @override
  _createState createState() => _createState();
}

class _createState extends State<create> {
  bool isSwitched = false;
  String? name, ph, comment, pic, a;
  var m;

  String? dop, doj, uid;
  File? imageFile;
  File? target_file;
  File? file;

  var cachemage;

  DateTime? now;

  String file_path = "Create a new Profile ";
  var buttonenabled = false;
  double active = 0;
  Object? dropdownValue;
  ImagePicker picker = ImagePicker();

  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;

    double y = MediaQuery.of(context).size.height;

    final iskeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: 1.0,
        ),
        child: Material(
          color: Color.fromARGB(255, 0, 0, 0),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: y / 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(
                    height: y / 20,
                  ),
                  InkWell(
                    onTap: () async {
                      String now = DateFormat("yyyy-MM-dd hh:mm:ss")
                          .format(DateTime.now());

                      dop = now;
                      doj = now;
                      PickImage();
                    },
                    child: Column(
                      children: [
                        if (!iskeyboard)
                          Column(
                            children: [
                              if (file != null)
                                Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    clipBehavior: Clip.hardEdge,
                                    child: Image.file(
                                      File(file!.path),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  height: y / 4,
                                  width: x * .55,
                                ),
                              if (file == null)
                                Container(
                                  child: randomAvatar(
                                      DateTime.now().toIso8601String(),
                                      trBackground: true,
                                      height: 50,
                                      width: 50),
                                  height: y / 4,
                                  width: x * .55,
                                ),
                            ],
                          )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: y / 25,
                  ),
                  Text(
                    file_path,
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          color: Colors.lightBlueAccent, letterSpacing: .5),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
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
                              setState(() {
                                name = value;
                              });
                            },
                            textAlign: TextAlign.center,
                            maxLength: 15,
                            decoration: const InputDecoration(
                                border: InputBorder.none, hintText: 'Name'),
                          ),
                          TextField(
                            style: TextStyle(fontWeight: FontWeight.bold),
                            onChanged: (value) {
                              setState(() {
                                ph = value;
                              });
                            },
                            maxLines: 1,
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Phone Number'),
                          ),
                          TextField(
                            style: TextStyle(fontWeight: FontWeight.bold),
                            onChanged: (value) {
                              setState(() {
                                m = value;
                              });
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
                            style: TextStyle(fontWeight: FontWeight.bold),
                            onChanged: (value) {
                              setState(() {
                                a = value;
                                setState(() {
                                  if (m != null && m != 0) {
                                    buttonenabled = true;
                                    active = y / 15;
                                  }
                                });
                              });
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
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    height: y / 2.5,
                    width: x * .85,
                  ),
                  SizedBox(
                    height: y / 25,
                  ),
                  Container(
                    child: Center(
                      child: SfDateRangePicker(
                        onSelectionChanged: _onSelectionChanged,
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[100],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    height: y / 2.5,
                    width: x * .85,
                  ),
                  SizedBox(
                    height: y / 25,
                  ),
                  InkWell(
                    onTap: () {
                      if (m != null && a != null && m != 0) {
                        upload_image();
                        int increment = int.parse(m!) * (30);
                        var doe = now!.add(Duration(days: increment));

                        print(FirebaseApi.write(name!, ph!, pic!, dop!,
                            doe.toString(), doj!, m!, a!));
                        showTopSnackBar(
                          context,
                          const CustomSnackBar.success(
                            backgroundColor: const Color(0xFF2D2F41),
                            message: "New User Sucessfully Added",
                          ),
                        );
                        sms.smscreate(ph!, name, doe);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => dashboard()));
                      } else {
                        setState(() {
                          file_path = "Kindly Check the data entered";
                        });
                      }
                    },
                    child: Container(
                      width: x / 4,
                      height: x / 7,
                      child: Center(
                        child: Text(
                          "Create",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w900),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 215, 197),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(
                    height: y / 25,
                  ),
                  AnimatedButton(
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
                  SizedBox(
                    height: y / 25,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  PickImage() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false, allowCompression: true, type: FileType.image);
    if (result == null) return;
    final path = result.files.single.path!;

    file = await FlutterNativeImage.compressImage(path,
        quality: 50, targetWidth: 240, targetHeight: 320);
    setState(() {
      file!;
    });
  }

  Future<String> upload_image() async {
    if (file == null) {
      print("no file found ");
      return "Nothing";
    }
    String filename = name! + ph!;

    final destination = 'Avatars/$filename';
    String url = await FirebaseApi.upget(destination, file!);

    print(url);
    setState(() {
      pic = url;
    });
    return "non nullable return ";
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      now = args.value;
      dop = now.toString();
      doj = now.toString();
    });
  }
}

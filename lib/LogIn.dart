import 'package:dharims_web/Dashboard.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:animated_button/animated_button.dart';
import 'package:lottie/lottie.dart';


import 'Logo.dart';

class sign extends StatefulWidget {
  @override
  State<sign> createState() => _signState();
}

class _signState extends State<sign> {
  bool isHover = false;

  String? mail, passcode;
  @override
  Widget build(BuildContext context) {
    final double x = MediaQuery.of(context).size.width;
    final double y = MediaQuery.of(context).size.height;
    final authie = FirebaseAuth.instance;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: 1.0,
      ),
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        // floatingActionButton: SizedBox(
        //   child: AnimatedButton(
        //     height: 50,
        //     width: 50,
        //     color: Colors.deepPurpleAccent,
        //     onPressed: () {
        //       Navigator.push(
        //           context, MaterialPageRoute(builder: (context) => Homepage()));
        //     },
        //     child: Icon(
        //       Icons.arrow_back,
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: y / 5,
              child: Center(
                child: Lottie.network(
                    'https://firebasestorage.googleapis.com/v0/b/dharims-886b0.appspot.com/o/Assets%2F69454-gym-grandma-and-granpa.json?alt=media&token=0c725ead-baab-40e5-a844-52c7e2a041b1'),
                // child: Image.network(
              ),
            ),
            Center(
              child: Stack(
                alignment: Alignment.topRight,
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(40))),
                    height: y / 4,
                    width: x * .85,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              mail = value.toString().trim();
                            });
                          },
                          textAlign: TextAlign.center,
                          maxLength: 50,
                          style: GoogleFonts.poppins(),
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: 'Mail'),
                        ),
                        TextField(
                          style: GoogleFonts.poppins(),
                          onChanged: (value) {
                            setState(() {
                              passcode = value;
                            });
                          },
                          obscureText: true,
                          textAlign: TextAlign.center,
                          maxLength: 20,
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: 'Passcode'),
                        ),
                      ],
                    ),
                    // Image.asset('assets/launcher.png'),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: AnimatedButton(
                    height: 50,
                    width: 150,
                    color: Color.fromARGB(255, 49, 250, 186),
                    onPressed: () async {
                     

                      try {
                        await authie.signInWithEmailAndPassword(
                            email: mail!, password: passcode!);
                       

                        setState(() {});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => dashboard()));
                      } on FirebaseAuthException catch (e) {
                        print(e);
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                         
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignIn()));
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
                      }
                    },
                    child: Text(
                      'LOG IN ',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 0, 0, 0),
                            letterSpacing: .5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

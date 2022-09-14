import 'package:animated_button/animated_button.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'Logo.dart';

class logout extends StatefulWidget {
  const logout({Key? key}) : super(key: key);

  @override
  _logoutState createState() => _logoutState();
}

class _logoutState extends State<logout> {
  @override
  Widget build(BuildContext context) {
return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: 1.0,
      ),
      child: Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: AnimatedButton(
                color: Color.fromARGB(255, 121, 108, 205),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
                },
                child: Text(
                  'Log Out',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        letterSpacing: .5),
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),)
    );
  }
}

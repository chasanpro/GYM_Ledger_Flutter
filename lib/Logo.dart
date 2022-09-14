import 'package:dharims_web/Dashboard.dart';
import 'package:dharims_web/LogIn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:animated_button/animated_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:local_auth/local_auth.dart';

import 'package:lottie/lottie.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> {
  bool _isLoggedIn = false;
  // ignore: unused_field
  late GoogleSignInAccount _userObj;
  final LocalAuthentication auth = LocalAuthentication();

  // ignore: unused_field
  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
    if (_isLoggedIn == true) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => dashboard()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double x = MediaQuery.of(context).size.width;
    final double y = MediaQuery.of(context).size.height;
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: 1.0,
      ),
      child: SafeArea(
        top: false,
        bottom: true,
        minimum: const EdgeInsets.all(0.0),
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          body: Center(
            child: Column(
              children: [
                const Spacer(),
                Stack(
                  alignment: Alignment.topRight,
                  children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(210, 0, 0, 0),
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(40))),
                      height: y / 2,
                      width: x * .95,
                      child: Lottie.network(
                          'https://firebasestorage.googleapis.com/v0/b/dharims-886b0.appspot.com/o/Assets%2F81327-coch-cencept-animation.json?alt=media&token=6905de23-1113-4a91-bccc-4894ec06699a'),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          borderRadius: const BorderRadius.all(
                              const Radius.circular(40))),
                      child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Image.network(
                              "https://firebasestorage.googleapis.com/v0/b/dharims-886b0.appspot.com/o/Avatars%2Findia.jpg?alt=media&token=35ed57f6-215b-487d-a244-972ff68a2f73")),
                      width: 50,
                      height: 50,
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  height: y * .4,
                  child: Column(
                    children: [
                      Text(
                        'Dharims ',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              color: Color.fromARGB(255, 255, 215, 197),
                              letterSpacing: .5),
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Fitnesszone ',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              color: Color.fromARGB(255, 255, 215, 197),
                              letterSpacing: .5),
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'The Muscle Town ',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              color: Colors.white, letterSpacing: .5),
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: .025 * y,
                      ),
                      AnimatedTextKit(
                        totalRepeatCount: 1,
                        animatedTexts: [
                          TyperAnimatedText(
                              'Developed by Chaitanya Damarasingu',
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 15,
                                  // fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w800)),
                        ],
                      ),
                      Spacer(),
                      AnimatedButton(
                          color: Colors.greenAccent,
                          onPressed: () async {
                            if (FirebaseAuth.instance.currentUser?.uid ==
                                null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => sign()));
                              // not logged
                            } else {
                              try {
                                await auth
                                    .authenticate(
                                        localizedReason:
                                            'Please authenticate to show account balance',
                                        options: const AuthenticationOptions(
                                            biometricOnly: true))
                                    .whenComplete(() => {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      dashboard()))
                                        });

                                // ···
                              } on PlatformException catch (e) {
                                print(e);
                              }

                              // logged
                            }
                          },
                          child: Textalter("DIVE-IN")),
                      Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GoogelSignProvider extends ChangeNotifier {
  final gsign = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  Future glogin() async {
    final googleuser = await gsign.signIn();
    if (googleuser == null) return;
    _user = googleuser;
    final googleAuth = await googleuser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

Textalter(String label) {
  return Text(
    '$label',
    style: GoogleFonts.montserrat(
      textStyle: const TextStyle(
          color: Color.fromARGB(255, 0, 0, 0), letterSpacing: .2),
      fontSize: 15,
      fontWeight: FontWeight.w600,
    ),
  );
}

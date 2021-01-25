import 'package:cerromar/screens/home.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
// import "package:flutter/services.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:flutter/foundation.dart" show kIsWeb;
import "dart:io" show Platform;
import "package:hive/hive.dart";
import "package:path_provider/path_provider.dart";

Image myImage;
var googleAuthStorage;
GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    // "email",
    "https://mail.google.com/",
    "https://www.googleapis.com/auth/gmail.modify",
    "https://www.googleapis.com/auth/gmail.readonly",
    "https://www.googleapis.com/auth/gmail.metadata",
    "https://www.googleapis.com/auth/drive",
    "https://www.googleapis.com/auth/documents",
    "https://www.googleapis.com/auth/spreadsheets",
    "https://www.googleapis.com/auth/presentations",
    "https://www.googleapis.com/auth/contacts.readonly",
    "https://www.googleapis.com/auth/admin.directory.user",
    "https://www.googleapis.com/auth/admin.directory.group",
    "https://www.googleapis.com/auth/classroom.coursework.students",
    "https://www.googleapis.com/auth/classroom.courses",
    "https://www.googleapis.com/auth/classroom.announcements",
    "https://www.googleapis.com/auth/classroom.rosters",
  ],
  hostedDomain: "lreginaldofischione.edu.co",
);

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title, this.nueva}) : super(key: key);

  final String title;
  final double nueva;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class User {
  String uid;
  String email;
  String photoUrl;
  String displayName;

  User({
    this.uid,
    this.email,
    this.photoUrl,
    this.displayName,
  });
}

signInWithGoogle(BuildContext context) async {
  try {
    final googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    await googleAuthStorage.put("accessToken", googleAuth.accessToken);
    await googleAuthStorage.put("idToken", googleAuth.idToken);
    // showAlertDialog(context, 'porfin ' + googleUser.email, "Inf de acceso 0");
    // print(['googleAuth.accessToken', googleAuth.accessToken]);
    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    // showAlertDialog(context, 'porfin ' + googleUser.email, "Inf de acceso 1");
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return HomePage();
        },
      ),
    );
  } catch (e) {
    print(["Error el el login", e]);
    showAlertDialog(context, e.toString(), "Error el el login");
    return null;
  }
}

showAlertDialog(BuildContext context, String texto, String titulo) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(titulo),
    content: Text(texto),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class _LoginPageState extends State<LoginPage> {
  initializeHive() async {
    if (kIsWeb) {
      print(["Flutter Web"]);
      googleAuthStorage = await Hive.openBox('googleAuthStorage');
      print('Hive web is ok');
    } else if (Platform.isAndroid) {
      final dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
      googleAuthStorage = await Hive.openBox("googleAuthStorage");
      print('Hive is ok');
    }
  }

  @override
  void initState() {
    initializeHive();
    super.initState();
    myImage = Image.asset(
      "assets/logos/google.png",
      width: 80,
      height: 80,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF144d8b),
      child: Center(
        child: GestureDetector(
          onTap: () {
            print("Login with Google");
            signInWithGoogle(context);
            /* Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return HomePage();
            })) */
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: myImage,
            /* Image(
              image: AssetImage('assets/logos/google.png'),
              width: 80,
              height: 80,
            ), */
          ),
        ),
      ),
    );
  }
}

import 'package:cerromar/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MyApp(firebaseApp: Firebase.initializeApp()),
  );
}

FirebaseFirestore firestore = FirebaseFirestore.instance;
bool isDarkModeEnabled = false;

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> firebaseApp;
  const MyApp({this.firebaseApp});

  @override
  Widget build(BuildContext context) {
    // _initStorage();
    return FutureBuilder(
      future: firebaseApp,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          FirebaseFirestore.instanceFor(
            app: snapshot.data,
          );
          if (kIsWeb) {
            print('Flutter Web');
            // FirebaseFirestore.instance.settings.sslEnabled;
            // FirebaseFirestore.instance.enablePersistence();
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Inventarios denzil',
              home: LoginPage(
                  title: 'Flutter Cerromar App',
                  nueva: 45), //(location: 'sedes'),
            );
          } else if (Platform.isAndroid) {
            print('Flutter Android');
            FirebaseFirestore.instance.settings =
                Settings(persistenceEnabled: true);
            FirebaseFirestore.instance.settings =
                Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Cerromar App',
              home: LoginPage(title: 'Flutter Cerromar App', nueva: 45),
            );
          }
        }
        return Center(
          child: Container(
              width: 100, height: 100, child: CircularProgressIndicator()),
        );
      },
    );
  }
}
/* void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(title: 'Flutter Demo Home Page', nueva: 45),
    );
  }
} */

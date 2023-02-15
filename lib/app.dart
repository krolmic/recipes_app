import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// you have to run `flutterfire configure` to create it
import 'firebase_options.dart';
import 'package:recipes_app/utils/store.dart';

import 'package:recipes_app/ui/screens/home.dart';
import 'package:recipes_app/ui/screens/login.dart';
import 'package:recipes_app/ui/theme.dart';

Future<FirebaseApp> initializeFirebase() async {
  var a = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await seedStore();
  return a;
}

class RecipesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipes',
      theme: buildTheme(),
      debugShowCheckedModeBanner: false,
      routes: {
        // '/': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
      },
      home: FutureBuilder(
        future: initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return HomeScreen();
          }

          return Container(
            color: Colors.white,
          );
        },
      ),
    );
  }
}

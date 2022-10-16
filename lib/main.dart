import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_flutter/screens/HomePage.dart';
import 'package:firebase_flutter/screens/SingUpScreen.dart';
import 'package:firebase_flutter/screens/anothr_screen.dart';
import 'package:firebase_flutter/screens/loginpage.dart';
import 'package:firebase_flutter/screens/notifction_firebase.dart';
import 'package:firebase_flutter/screens/singinScreen.dart';
import 'package:flutter/material.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp( MaterialApp(initialRoute: 'AuthorScreen',
    debugShowCheckedModeBanner: false,
    routes:{
      '/': (context) => const Homepage(),
      'loginpage':(context) => const loginPage(),
      'notifction':(context) => const notifctionPage(),
      '/': (context) => const Homepage(),
      //'SpalceScreen': (context) =>const  SpalceScreen(),
      'SinginScreen': (context)=>const SinginScreen(),
      'SingUpScreen' : (context)=> const SingUpScreen(),
      'AuthorScreen' : (context)=> const AuthorScreen(),
    }
  ));
}

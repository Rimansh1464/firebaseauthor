import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../helper/firebase_helper.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  String email = "";
  String password = "";

  String email1 = "";
  String password1 = "";

  TextEditingController singupEmail = TextEditingController();
  TextEditingController singupPassword = TextEditingController();

  TextEditingController singinEmail = TextEditingController();
  TextEditingController singinPassword = TextEditingController();

  final GlobalKey<FormState> sinfinfromkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("firebase"),
      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: singupEmail,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please Enter Email";
                    }
                  },
                  onSaved: (val) {
                    email = val!;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: "email",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: singupPassword,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please Enter Password";
                    }
                  },
                  onSaved: (val) {
                    email = val!;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: "Password",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    String? res = await FirebaseAuthHelper.firebaseAuthHelper
                        .singup(
                        email: singupEmail.text, password: singupPassword.text);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Uid=== $res")));
                  },
                  child: const Text("Sing up"),
                ),
                const Divider(
                  height: 50,
                  color: Colors.black,
                ),
                ElevatedButton(
                  onPressed: () {
                    signinDilog();
                  },
                  child: const Text("Sing in "),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () async{
                        User? res = await FirebaseAuthHelper.firebaseAuthHelper.googlelogin();
                      Navigator.pushNamed(context, '/');
                        },

                      child: const Text("Google login "),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        String? res = await FirebaseAuthHelper.firebaseAuthHelper
                            .anonymousSingIn();
                        Navigator.pushNamed(context, '/');
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("Uid=== $res")));
                      },
                      child: const Text("Anonymous"),
                    ),
                  ],

                ),
                ElevatedButton(
                  onPressed: () async {
                    String? res = await FirebaseAuthHelper.firebaseAuthHelper
                        .anonymousSingIn();
                    Navigator.pushNamed(context, 'notifction');
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Uid=== $res")));
                  },
                  child: const Text("Anonymous"),
                )
              ],
            ),
          )),
    );
  }

  signinDilog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Sign in"),
          content: Form(
            key: sinfinfromkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: singinEmail,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please Enter Email";
                    }
                  },
                  onSaved: (val) {
                    email1 = val!;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: "email",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: singinPassword,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please Enter Password";
                    }
                  },
                  onSaved: (val) {
                    password1 = val!;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: "Password",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    String? res = await FirebaseAuthHelper.firebaseAuthHelper
                        .singIn(
                        email: singinEmail.text,
                        password: singinPassword.text);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Uid=== $res")));
                    // Navigator.of(context).pop()
                    Navigator.pushNamed(context, '/');
                  },
                  child: const Text("Sing up"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

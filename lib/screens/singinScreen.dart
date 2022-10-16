import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../colour.dart';
import '../helper/firebase_helper.dart';

class SinginScreen extends StatefulWidget {
  const SinginScreen({Key? key}) : super(key: key);

  @override
  State<SinginScreen> createState() => _SinginScreenState();
}

class _SinginScreenState extends State<SinginScreen> {
  @override
  TextEditingController singinEmail = TextEditingController();
  TextEditingController singinPassword = TextEditingController();

  String email = "";
  String password = "";

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Center(
              child: Container(
                height: 684,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        height: 5,
                        thickness: 5,
                        endIndent: 130,
                        indent: 130,
                        color: Colors.grey,
                      ),
                      Center(
                        child: Image.asset('asserts/image/20943394_prev_ui.png',
                            height: 260, width: 280),
                      ),
                      Text(
                        "Welcome Back",
                        style: TextStyle(
                            color: mainColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "Les's login for explore continues",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: singinEmail,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please Enter Email";
                          }
                        },
                        onSaved: (val) {
                          email = val!;
                        },
                        decoration: InputDecoration(
                            hintText: 'Enter Email ',
                            hintStyle: TextStyle(color: mainColor),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: mainColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mainColor))),
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
                          password = val!;
                        },
                        obscureText: true,
                        decoration: InputDecoration(

                            hintText: 'Enter Password',
                            hintStyle: TextStyle(color: mainColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mainColor)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mainColor))),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            "Forgot Password ?",
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 27,
                      ),
                      InkWell(
                        onTap: () async {
                          {
                            try {
                              String? res = await FirebaseAuthHelper
                                  .firebaseAuthHelper
                                  .singIn(
                                      email: singinEmail.text,
                                      password: singinPassword.text);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Uid=== $res")));
                              // Navigator.of(context).pop()
                              Navigator.pushNamed(context, '/');
                            } on FirebaseException catch (e) {
                              switch (e.code) {
                                case "invalid-email":
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: Colors.redAccent,
                                            content: Text("Email not valid")));
                                  }
                                  break;
                                case "wrong-password":
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(

                                          behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.redAccent,
                                            action: SnackBarAction(label: "Remove", onPressed: (){
                                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                            }),
                                            content: Text("Password is wrong")));
                                  }
                                  break;
                              }
                            }
                          };
                        },
                        child: Container(
                          height: 65,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                            color: mainColor,
                          ),
                          child: const Center(
                            child: Text(
                              "Sing in",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, 'SingUpScreen');
                          },
                          child: Text.rich(TextSpan(
                              text: "Don't have an account ?",
                              style: TextStyle(
                                  color: mainColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                              children: const [
                                TextSpan(
                                  text: " Sing up here",
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                )
                              ])),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

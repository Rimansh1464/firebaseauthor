import 'package:flutter/material.dart';

import '../colour.dart';
import '../helper/firebase_helper.dart';
class SingUpScreen extends StatefulWidget {
  const SingUpScreen({Key? key}) : super(key: key);

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
 TextEditingController singupEmail = TextEditingController();
 TextEditingController singupPassword = TextEditingController();
 String email = "";
 String password = "";

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:mainColor,
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
                      const SizedBox(height: 8,),
                      const Divider(height: 5,thickness: 5,endIndent: 130,indent: 130,color: Colors.grey,),
                      Center(
                        child: Image.asset('asserts/image/2.png',
                            height: 190, width: 240),
                      ),
                      Text(
                        "Getting Started",
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


                      const SizedBox(
                        height: 7,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Enter Your name',
                            hintStyle: TextStyle(color: mainColor),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mainColor)),enabledBorder:OutlineInputBorder(
                            borderSide: BorderSide(color: mainColor)) ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),


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
                        decoration: InputDecoration(
                            hintText: 'Enter Email ',
                            hintStyle: TextStyle(color: mainColor),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: mainColor),),enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: mainColor))),
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
                        decoration: InputDecoration(
                            hintText: 'Enter Password',
                            hintStyle: TextStyle(color: mainColor),
                            border: OutlineInputBorder(

                                borderRadius: BorderRadius.circular(10),
                            ),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: mainColor)),enabledBorder:OutlineInputBorder(
                            borderSide: BorderSide(color: mainColor)) ),
                      ),
                      const SizedBox(
                        height: 5,
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
                      InkWell(onTap: ()async {
                        String? res = await FirebaseAuthHelper.firebaseAuthHelper
                            .singup(
                            email: singupEmail.text, password: singupPassword.text);
                        Navigator.pushNamed(context, 'SinginScreen');
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("Uid => $res")));
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
                              style: TextStyle(color: Colors.white, fontSize: 18),
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
                            Navigator.pushNamed(context, 'SinginScreen');
                          },
                          child: Text.rich(TextSpan(
                              text: "Already have Account ? ",
                              style: TextStyle(
                                  color: mainColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                              children: const [
                                TextSpan(
                                  text: " Sing in",
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

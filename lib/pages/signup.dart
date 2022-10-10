// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_app_firebase/src/Widget/new_text_faild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../component/alert.dart';
import '../src/Widget/submit_button.dart';
import '../src/model_clip/bezier_container.dart';
import '../src/const/valid.dart';
import 'login_page.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var userName, password, email;
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  registerNow() async {
    var formatData = formState.currentState;
    if (formatData!.validate()) {
      formatData.save();
      try {
        showLoading(context);

        final UserCredential credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        return credential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Navigator.of(context).pop();
          AwesomeDialog(
                  context: context,
                  title: "Error",
                  body: const Text("The password provided is too weak."))
              .show();
        } else if (e.code == 'email-already-in-use') {
          Navigator.of(context).pop();
          AwesomeDialog(
                  context: context,
                  title: "Error",
                  body:
                      const Text("The account already exists for that email."))
              .show();
        }
      } catch (e) {
        print(e);
      }
    } else {
      debugPrint("kkk");
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: const BezierContainer(),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    const SizedBox(
                      height: 50,
                    ),
                    Form(
                      key: formState,
                      child: Column(
                        children: <Widget>[
                          NewTextField(
                            title: "Username",
                            validator: (val) {
                              return validInput(val!, 2, 30);
                            },
                            onSaved: (val) {
                              userName = val;
                            },
                          ),
                          NewTextField(
                            title: "Email id",
                            validator: (val) {
                              return validInput(val!, 2, 30);
                            },
                            onSaved: (val) {
                              email = val;
                            },
                          ),
                          NewTextField(
                            title: "Password",
                            isPassword: true,
                            validator: (val) {
                              return validInput(val!, 2, 30);
                            },
                            onSaved: (val) {
                              password = val;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SubmitButton(
                        title: "Register Now",
                        onTap: () async {
                          UserCredential response = await registerNow();

                          debugPrint("============================");
                          // ignore: unnecessary_null_comparison
                          if (response != null) {
                            await FirebaseFirestore.instance.collection("users").add({
                              "username": userName,
                              "email":email
                            });
                            Navigator.of(context)
                                .pushReplacementNamed("homePage");
                          } else {
                            debugPrint("sign up field");
                          }
                          debugPrint(response.user!.email);
                          debugPrint("======================");
                        }),
                    SizedBox(height: height * .14),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
          text: 'no',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xffe46b10)),
          children: [
            TextSpan(
              text: 'te',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'App',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:note_app_firebase/pages/add_note_page.dart';
import 'package:note_app_firebase/pages/home_page.dart';
import 'package:note_app_firebase/pages/login_page.dart';
import 'pages/signup.dart';

bool? isLogin;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var user =FirebaseAuth.instance.currentUser;
  if (user ==null) {
    isLogin =false;
  } else {
    isLogin=true;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      initialRoute: isLogin==false?"login":"homePage",
      routes: {
        "login":(context)=>const LoginPage(),
        "signUp":(context)=>const SignUpPage(),
        "homePage":(context)=>const HomePage(),
        "addNote":(context)=>const AddNotePage(),
      },
    );
  }
}


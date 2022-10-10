import 'package:flutter/material.dart';
//إحضار كل جدول الuser
// getData()async{
//   FirebaseFirestore.instance.collection("users").get().then((value) => {
//     value.docs.forEach((element) {
//       print(element.data());
//       print("=========================================");
//     })
//   });
// }

//إحضار شخص واحد
// getData() async {
// var docs=  FirebaseFirestore.instance
//       .collection("users")
//       .doc("6B6N7hAoRsDtiGsD9PFW");
//      await docs.get().then((value) => print(value.exists));
//
// }

// if الشروط عند الاستدعاء من الداتا بيس
// getData()async{//whereIn[]
//   FirebaseFirestore.instance.collection("users").where("age",isGreaterThanOrEqualTo: 30).get().then((value) => {
//     value.docs.forEach((element) {
//       print(element.data());
//       print("=========================================");
//     })
//   });
// }

// الريال تايم
// getData()async{//whereIn[]
//   FirebaseFirestore.instance.collection("users").snapshots().listen((event) {
//     event.docs.forEach((element) {
//       print(element.data()['username']);
//       print(element.data()['phone']);
//       print(element.data()['age']);
//       print("=========================================");
//     });
//   });
// }

//إضافة الى قاعدة البيانات
//   addData()async{//whereIn[]
//     CollectionReference userRef= FirebaseFirestore.instance.collection("users");
//     // userRef.add({
//     //   "username":"mohammad",
//     //   "email":"mohammad@gmail.com",
//     //   "age":18,
//     // });
//     userRef.doc("1234445").set({
//       "username":"soso",
//       "email":"mohammad@gmail.com",
//       "age":30,
//     });
//   }

// deleteData() async {
//   //whereIn[]
//   CollectionReference userRef =
//       FirebaseFirestore.instance.collection("users");
//   // userRef.add({
//   //   "username":"mohammad",
//   //   "email":"mohammad@gmail.com",
//   //   "age":18,
//   // });
//   userRef.doc("74crYh0R10dkls1KlkmGXbmiv").delete().then((value) {
//     print("success");
//   }).catchError((e) {
//     print("error:$e");
//   });
// }


class HomeTestPage extends StatefulWidget {
  const HomeTestPage({Key? key}) : super(key: key);

  @override
  State<HomeTestPage> createState() => _HomeTestPageState();
}

class _HomeTestPageState extends State<HomeTestPage> {
  // Future<UserCredential> signInWithGoogle() async {
  //   // Trigger the authentication flow
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  //
  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //
  //   // Once signed in, return the UserCredential
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  //late UserCredential userCredential;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: MaterialButton(
             color: Colors.red,
              onPressed: ()async{
               // Anonymous
                // userCredential = await FirebaseAuth.instance.signInAnonymously();
               // debugPrint(userCredential.user?.uid);

                // try {
                //    userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                //       email: "ali@example.com",
                //       password: "SuperSecretPassword!"
                //   );
                //    debugPrint(userCredential.toString());
                // } on FirebaseAuthException catch (e) {
                //   if (e.code == 'weak-password') {
                //     debugPrint('The password provided is too weak.');
                //   } else if (e.code == 'email-already-in-use') {
                //     debugPrint('The account already exists for that email.');
                //   }
                // } catch (e) {
                //   print(e);
                // }
               },
              child:const Text("sign In"),

            ),
          ),
          Center(
            child: MaterialButton(
             color: Colors.blue,
              onPressed: ()async{
               // Anonymous
                // userCredential = await FirebaseAuth.instance.signInAnonymously();
               // debugPrint(userCredential.user?.uid);

                // try {
                //    userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                //       email: "ali@example.com",
                //       password: "SuperSecretPassword!"
                //   );
                //    debugPrint(userCredential.toString());
                // } on FirebaseAuthException catch (e) {
                //   if (e.code == 'user-not-found') {
                //     print('No user found for that email.');
                //   } else if (e.code == 'wrong-password') {
                //     print('Wrong password provided for that user.');
                //   }
                // }

               //  UserCredential userCredential = await signInWithGoogle();
               //  print(userCredential);
                },
              child:const Text("logn In"),

            ),
          ),
        ],
      ),
    );
  }
}

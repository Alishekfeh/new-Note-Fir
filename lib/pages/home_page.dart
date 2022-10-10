import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:note_app_firebase/pages/edait_note.dart';
import 'dart:math' as math;
import 'package:firebase_storage/firebase_storage.dart';
import '../src/Widget/card_note.dart';
import '../src/model_clip/bezier_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference noteRef = FirebaseFirestore.instance.collection("notes");

  //
  getUser() {
    var user = FirebaseAuth.instance.currentUser;
    debugPrint(user!.email);
  }

  @override
  void initState() {
    //getImageAndFileFromFirBase();
    getUser();
    super.initState();
  }

  // DocumentReference userDoc = FirebaseFirestore.instance
  //     .collection("users")
  //     .doc("vq450XViKrutuRpY4bTJ");
  //
  // trans() async {
  //   FirebaseFirestore.instance.runTransaction((transaction) async {
  //     DocumentSnapshot docSnap = await transaction.get(userDoc);
  //     if (docSnap.exists) {
  //       transaction.update(userDoc, {"phone": "55555"});
  //     } else {
  //       debugPrint("user not Exist");
  //     }
  //   });
  // }

  late File file;

  // var imagePiker = ImagePicker();
  //
  // uploadImage() async {
  //   var imagePiked = await imagePiker.pickImage(source: ImageSource.camera);
  //
  //   if (imagePiked != null) {
  //     file = File(imagePiked.path);
  //     var nameImage = paths.basename(imagePiked.path);
  //     // debugPrint(nameImage);
  //     var random = math.Random().nextInt(1000000);
  //     nameImage = "$random$nameImage";
  //     var refStorage = FirebaseStorage.instance.ref("images/$nameImage");
  //     await refStorage.putFile(file);
  //     var url = await refStorage.getDownloadURL();
  //     debugPrint(url);
  //   } else {
  //     debugPrint("chose Image please");
  //   }
  // }
  //
  // getImageAndFileFromFirBase() async {
  //   var refStorage = await FirebaseStorage.instance
  //       .ref()
  //       .list(const ListOptions(maxResults: 1));
  //   for (var element in refStorage.items) {
  //     print(element.name);
  //   }
  //   for (var element in refStorage.prefixes) {
  //     print(element.name);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff60363C),
          onPressed: () {
            Navigator.of(context).pushNamed("addNote");
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SizedBox(
          height: height,
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: -height * .15,
                  right: -MediaQuery
                      .of(context)
                      .size
                      .width * .4,
                  child: const BezierContainer()),
              Positioned(
                  bottom: -height * .15,
                  left: -MediaQuery
                      .of(context)
                      .size
                      .width * .2,
                  child: Transform.rotate(
                      angle: -math.pi / 1.1, child: const BezierContainer())),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .08),
                      SizedBox(
                        height: double.maxFinite,
                        child: FutureBuilder(
                            future: noteRef
                                .where("userId",
                                isEqualTo:
                                FirebaseAuth.instance.currentUser?.uid)
                                .get(),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return const Text("Loading");
                              }
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Dismissible(

                                          onDismissed: (diretion) async {
                                            await noteRef
                                                .doc(snapshot
                                                .data.docs[index].id)
                                                .delete();
                                            await FirebaseStorage.instance
                                                .refFromURL(snapshot.data
                                                .docs[index]['imageUrl'])
                                                .delete()
                                                .then((value) =>
                                                debugPrint("Delete"));
                                          },
                                          key: UniqueKey(),
                                          child: CardNote(
                                            title: snapshot.data.docs[index]
                                                .data()['title'],
                                            titleNote: snapshot.data
                                                .docs[index]
                                                .data()['note'],
                                            imageUrl: snapshot.data
                                                .docs[index]
                                                .data()['imageUrl'],
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditNotePage(
                                                            dogId: snapshot
                                                                .data
                                                                .docs[index]
                                                                .id,
                                                            list: snapshot
                                                                .data
                                                                .docs[index],
                                                          )));
                                            },
                                          ),
                                        ),
                                      );
                                    });
                              }
                              return const Center(
                                  child: CircularProgressIndicator());
                            }),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(top: 40, right: 0, child: _backButton()),
            ],
          ),
        ));
  }

  Widget _backButton() {
    return InkWell(
      onTap: () async {
        await FirebaseAuth.instance.signOut();
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacementNamed("login");
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            const Text('Exit',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontStyle: FontStyle.italic)),
            const SizedBox(
              width: 6,
            ),
            Container(
              padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

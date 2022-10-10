// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../component/alert.dart';
import '../src/Widget/new_text_faild.dart';
import '../src/Widget/submit_button.dart';
import '../src/const/valid.dart';
import '../src/model_clip/bezier_container.dart';

class EditNotePage extends StatefulWidget {
  final   dogId;
  final   list;
  const EditNotePage({Key? key, this.dogId, this.list}) : super(key: key);

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  CollectionReference noteRef = FirebaseFirestore.instance.collection("notes");
  var title, note, imageUrl;
  File? file;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late Reference ref;

  addNote() async {
    var formData = formState.currentState;

    if (file ==null) {
      if (formData!.validate()) {
        showLoading(context);
        formData.save();
        await noteRef.doc(widget.dogId).update({
          "title": title,
          "note": note,
        });

        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacementNamed("homePage");
      }
 } else {
      if (formData!.validate()) {
        showLoading(context);
        formData.save();
        await ref.putFile(file!);

        imageUrl = await ref.getDownloadURL();

        await noteRef.doc(widget.dogId).update({
          "title": title,
          "note": note,
          "imageUrl": imageUrl,
        });

        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacementNamed("homePage");
      }
 }



  }

  Widget _emailPasswordWidget() {
    return Form(
      key: formState,
      child: Column(
        children: <Widget>[
          NewTextField(
            initialValue: widget.list['title'],
            title: "Edit Title",
            validator: (val) {
              return validInput(val!, 2, 30);
            },
            onSaved: (val) {
              title = val;
            },
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "Edit Note",
                  style:  TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    initialValue: widget.list['note'],
                    maxLines: 6,
                    keyboardType: TextInputType.multiline,
                    onSaved: (val) {
                      note = val;
                    },
                    validator: (val) {
                      return validInput(val!, 2, 70);
                    },
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        fillColor: Color(0xfff3f3f4),
                        filled: true))
              ],
            ),
          ),
        ],
      ),
    );
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
                  top: -height * .15,
                  right: -MediaQuery.of(context).size.width * .4,
                  child: const BezierContainer()),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .15),
                      _title(),
                      const SizedBox(height: 50),
                      _emailPasswordWidget(),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80),
                        child: SubmitButton(
                            title: "Edit Image",
                            onTap: () {
                              showBottomSheet();
                              //UserCredential user = await signIn();
                              // Navigator.of(context).pushReplacementNamed("homePage");
                            }),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SubmitButton(
                            title: "Edit Note",
                            onTap: () async {
                              await addNote();
                              // UserCredential user = await signIn();

                              //Navigator.of(context).pushReplacementNamed("homePage");
                            }),
                      ),
                      SizedBox(height: height * .055),
                    ],
                  ),
                ),
              ),
              Positioned(top: 40, left: 0, child: _backButton()),
            ],
          ),
        ));
  }

  showBottomSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(20),
            height: 170,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "please chose image",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () async {
                          var piked = await ImagePicker()
                              .pickImage(source: ImageSource.camera);
                          if (piked != null) {
                            file = File(piked.path);
                            var rand = Random().nextInt(1000000);
                            var imageName = "$rand+path.basename(piked.path)";
                            ref = FirebaseStorage.instance
                                .ref("images")
                                .child(imageName);
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                          }
                        },
                        child: Expanded(
                          child: Column(
                            children: const [
                              Text('From Camera'),
                              Icon(
                                Icons.camera,
                                color: Color(0xfff7892b),
                                size: 55,
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          var piked = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (piked != null) {
                            file = File(piked.path);
                            var rand = Random().nextInt(1000000);
                            var imageName = "$rand+path.basename(piked.path)";
                            ref = FirebaseStorage.instance
                                .ref("images")
                                .child(imageName);
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                          }
                        },
                        child: Expanded(
                          child: Column(
                            children: const [
                              Text('From gallery'),
                              Icon(
                                Icons.image,
                                color: Color(0xfff7892b),
                                size: 55,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: const Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            const Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
          text: 'Edit ',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
              color: Color(0xffe46b10)),
          children: [
            TextSpan(
              text: 'No',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'te',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }
}

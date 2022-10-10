import 'package:flutter/material.dart';

class ViewNote extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final note;

  const ViewNote({Key? key, this.note}) : super(key: key);

  @override
  State<ViewNote> createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor:const Color(0xff67364C),
        title: Text("${widget.note['title']}"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            "${widget.note['imageUrl']}",
            height: 330,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("${widget.note['note']}",style:const  TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              fontStyle: FontStyle.italic,
              color: Color(0xff38797F)
            ),),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CardNote extends StatelessWidget {
  final String title, titleNote,imageUrl;
  final  void Function()? onPressed;

  const CardNote({Key? key, required this.title, required this.titleNote, required this.imageUrl,required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: const Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                //
                end: Alignment.centerRight,
                // colors: [Color(0xfffbb448), Color(0xfff7892b)])),
                colors: [Color(0xff67364C), Color(0xff38797F)])),
        child: Row(
         // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child:Container(
                    height: 140,
                    //transform: Matrix4.translationValues(-0.0, -15.0, 0.0),
                    decoration:  BoxDecoration(
                        borderRadius:const BorderRadius.only(topLeft: Radius.circular(35)),

                        image: DecorationImage(

                            image: NetworkImage(imageUrl
                            ),
                            fit: BoxFit.cover)),
                  ),

                )),
            Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          transform: Matrix4.translationValues(10.0, -22.0, 0.0),
                          child: Text(
                            title,
                            style: const TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                fontSize: 24),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        transform: Matrix4.translationValues(10.0, -32.0, 0.0),
                        child: Text(
                          titleNote,
                          style: const TextStyle(
                              color: Colors.orange, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                )),
            Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Container(
                      transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                      child: InkWell(
                        onTap: onPressed,
                        child: IconButton(
                            onPressed: onPressed,
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white54,
                            )),
                      ),
                    ),
                  ],
                )),
          ],
        ));
  }
}

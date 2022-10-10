import 'package:flutter/material.dart';
class SubmitButton extends StatelessWidget {
  final String title;
  final void Function() onTap;
  const SubmitButton({Key? key, required this.title, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap ,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: const Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
               // colors: [Color(0xfffbb448), Color(0xfff7892b)])),
                colors: [Color(0xfff7892b), Color(0xffBd5161)])),
        child: Text(
          title,
          style:const  TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}

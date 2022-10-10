import 'package:flutter/material.dart';

class NewTextField extends StatelessWidget {
  final String title;
  final bool isPassword;
  final String? Function(String?) validator;
  final void Function(String?) onSaved;
  final String? initialValue;

  const NewTextField(
      {Key? key,
      required this.title,
      this.isPassword = false,
      required this.validator,
      required this.onSaved, this.initialValue=""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
              initialValue: initialValue,
              onSaved: onSaved,
              validator: validator,
              obscureText: isPassword,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

enum TextFieldTypes { title, description }

class NoteTextField extends StatelessWidget {
  final String placeholder;
  final TextFieldTypes textFieldType;
  final TextEditingController controller;

  const NoteTextField({
    super.key,
    this.placeholder = "",
    this.textFieldType = TextFieldTypes.description,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: TextField(
        maxLines: textFieldType == TextFieldTypes.description ? 10 : 1,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: placeholder,
          hintStyle: TextStyle(
            color: Colors.black38,
            fontSize: textFieldType == TextFieldTypes.title ? 24 : 14,
          ),
        ),
        style: TextStyle(
          fontSize: textFieldType == TextFieldTypes.title ? 24 : 14,
        ),
        controller: controller,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:note_app/constants/colors.dart';

import '../models/note.dart';

class NoteDetails extends StatelessWidget {
  final Note note;
  const NoteDetails({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(note.title), backgroundColor: backgroundColor),
      body: Container(
        color: backgroundColor,
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(note.title, style: TextStyle(fontSize: 32)),
                  Text(
                    note.content,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

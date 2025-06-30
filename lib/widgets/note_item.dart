import 'package:flutter/material.dart';
import 'package:note_app/models/note.dart';

import '../screens/note_details.dart';

class NoteItem extends StatelessWidget {
  final Note note;

  const NoteItem({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
        child: ListTile(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NoteDetails(note: note)),
          ),
          title: Text(
            note.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          subtitle: Text(
            note.content,
            maxLines: 1,
            style: TextStyle(fontSize: 14, color: Colors.black38),
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.black45),
        ),
      ),
    );
  }
}

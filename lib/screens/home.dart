import 'package:flutter/material.dart';
import 'package:note_app/constants/colors.dart';
import 'package:note_app/data/notifiers.dart';
import 'package:note_app/screens/add_new_note.dart';

import '../models/note.dart' show Note;
import '../services/api_service.dart' show ApiService;
import '../widgets/note_item.dart' show NoteItem;

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _apiService.fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AddNewNote();
                },
              ),
            ),
          ),
        ],
        title: Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 10,
            shadows: [
              Shadow(
                color: Colors.black26,
                blurRadius: 3,
                offset: Offset(2, 4),
              ),
            ],
          ),
        ),
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: Container(
        color: backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: isLoadingNotifier,
              builder: (context, isLoading, child) {
                if (isLoading) {
                  return Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                return ValueListenableBuilder<bool>(
                  valueListenable: isErrorNotifier,
                  builder: (context, isError, child) {
                    if (isError) {
                      return Expanded(
                        child: Center(
                          child: Text("Hata: Veri çekilirken bir hata oluştu!"),
                        ),
                      );
                    }
                    return ValueListenableBuilder<List<Note>>(
                      valueListenable: noteListNotifier,
                      builder: (context, noteList, child) {
                        if (noteList.isEmpty) {
                          return Expanded(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Henüz not yok",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => AddNewNote(),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.add),
                                        Text("İlk notunu yaz"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        return Expanded(
                          child: ListView(
                            children: [
                              SizedBox(height: 16),
                              ...noteList.map((note) => NoteItem(note: note)),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

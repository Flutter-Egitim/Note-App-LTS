import 'package:flutter/material.dart';
import 'package:note_app/constants/colors.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/services/api_service.dart';

import '../widgets/note_text_field.dart';

class AddNewNote extends StatefulWidget {
  const AddNewNote({super.key});

  @override
  State<AddNewNote> createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {
  final ApiService _service = ApiService();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    // Controller'ları dispose et
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni not ekle"),
        backgroundColor: backgroundColor,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          color: backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  children: [
                    NoteTextField(
                      controller: _titleController,
                      placeholder: "Başlık...",
                      textFieldType: TextFieldTypes.title,
                    ),
                    NoteTextField(
                      controller: _contentController,
                      placeholder: "Açıklama...",
                      textFieldType: TextFieldTypes.description,
                    ),
                  ],
                ),
              ),

              ElevatedButton(
                onPressed: () async {
                  if (_contentController.text.trim().isNotEmpty &&
                      _titleController.text.trim().isNotEmpty) {
                    try {
                      // Loading göster
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) =>
                            Center(child: CircularProgressIndicator()),
                      );

                      final success = await _service.createNote(
                        Note(
                          title: _titleController.text.trim(),
                          content: _contentController.text.trim(),
                        ),
                      );

                      // Loading dialog'unu kapat
                      Navigator.of(context).pop();

                      if (success) {
                        // Başarılı mesajı göster
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Not başarıyla eklendi!"),
                            backgroundColor: Colors.green,
                          ),
                        );
                        // Ana sayfaya dön
                        Navigator.pop(context);
                      } else {
                        // Hata mesajı göster
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Not eklenirken hata oluştu!"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    } catch (e) {
                      // Loading dialog'unu kapat (eğer açıksa)
                      Navigator.of(context).pop();

                      // Hata mesajı göster
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Beklenmeyen bir hata oluştu!"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  } else {
                    // Boş form elemanları için uyarı dialog göster
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Uyarı"),
                          content: Text(
                            "Başlık ve içerik alanları boş bırakılamaz!",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text("Tamam"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text("Kaydet"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:note_app/data/notifiers.dart';
import 'package:note_app/models/note.dart';

class ApiService {
  // API endpoint base URL
  final String baseUrl = 'https://68616b3e8e7486408445ee2a.mockapi.io';

  Future<http.Response> getNotes() async {
    final url = Uri.parse('$baseUrl/note');
    return await http.get(url);
  }

  Future<void> fetchNotes() async {
    isErrorNotifier.value = false;
    isLoadingNotifier.value = true;
    try {
      final response = await getNotes();
      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        List<Note> notes = jsonList.map((json) => Note.fromJson(json)).toList();
        noteListNotifier.value = notes;
      } else {
        isErrorNotifier.value = true;
        throw Exception("Notlar yüklenirken hata: ${response.statusCode}");
      }
    } catch (error) {
      isErrorNotifier.value = true;
    } finally {
      isLoadingNotifier.value = false;
    }
  }

  Future<bool> createNote(Note note) async {
    try {
      Note newNote = Note(title: note.title, content: note.content);
      final url = Uri.parse("$baseUrl/note");

      final noteJson = jsonEncode(newNote.toJson());

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: noteJson,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Response'tan yeni oluşturulan notu al
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final Note createdNote = Note.fromJson(responseData);

        // Mevcut listeye yeni notu ekle // Buradaki liste oluşturma şekli: List.from dediğimiz zaman yeni bir liste oluşturur ve mevcut listeyi kopyalar.
        // Böylece mevcut listeyi değiştirmeden yeni notu ekleyebiliriz.
        // Bu, notifier'ın dinleyicilerine değişiklikleri bildirmek için önemlidir.
        // Notifier'ın dinleyicileri, liste değiştiğinde otomatik olarak güncellenir.
        List<Note> currentNotes = List.from(noteListNotifier.value);
        currentNotes.add(createdNote);

        // Notifier'ı güncelle
        noteListNotifier.value = currentNotes;

        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}

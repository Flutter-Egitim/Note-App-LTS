class Note {
  String? id;
  String content;
  String title;

  Note({this.id, required this.title, required this.content});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(id: json['id'], content: json['content'], title: json['title']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'content': content, 'title': title};
  }
}

class Note {
  final String id;
  final String text;
  final DateTime createdAt;

  Note({
    required this.id,
    required this.text,
    required this.createdAt,
  });

  factory Note.fromMap(Map<String, dynamic> map, String id) {
    return Note(
      id: id,
      text: map['text'] ?? '',
      createdAt: (map['createdAt'] as dynamic).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'createdAt': createdAt,
    };
  }
}
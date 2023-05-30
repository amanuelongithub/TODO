const String tableNote = 'notes';


// we are using letter to our column filed  
class NoteFields {
  static final List<String> values = [
    // add all fileds
    id, isImportant, title, time, description
  ];

  static const String id = '_id';
  static const String isImportant = 'isImportant';
  static const String title = 'title';
  static const String description = 'description';
  static const String time = 'time';
}

class Note {
  final int? id;
  final bool isImportant;
  final String desprecation;
  final String title;
  final DateTime createdTime;

  const Note({
    this.id,
    required this.isImportant,
    required this.desprecation,
    required this.title,
    required this.createdTime,
  });

  Note copy({
    int? id,
    bool? isImportant,
    String? desprecation,
    String? title,
    DateTime? createdTime,
  }) =>
      Note(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        title: title ?? this.title,
        desprecation: desprecation ?? this.desprecation,
        createdTime: createdTime ?? this.createdTime,
      );
  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        isImportant: json[NoteFields.isImportant] == 1,
        title: json[NoteFields.title] as String,
        desprecation: json[NoteFields.description] as String,
        createdTime: DateTime.parse(json[NoteFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.isImportant: isImportant ? 1 : 0,
        NoteFields.description: desprecation,
        NoteFields.time: createdTime.toIso8601String(),
      };
}
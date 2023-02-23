final String tableNote = 'notes';


// we are using letter to our column filed  
class NoteFields {
  static final List<String> values = [
    // add all fileds
    id, isImportant, number, title, time, description
  ];

  static final String id = '_id';
  static final String isImportant = 'isImportant';
  static final String number = 'number';
  static final String title = 'title';
  static final String description = 'description';
  static final String time = 'time';
}

class Note {
  final int? id;
  final bool isImportant;
  final int number;
  final String desprecation;
  final String title;
  final DateTime createdTime;

  const Note({
    this.id,
    required this.isImportant,
    required this.number,
    required this.desprecation,
    required this.title,
    required this.createdTime,
  });

  Note copy({
    int? id,
    bool? isImportant,
    int? number,
    String? desprecation,
    String? title,
    DateTime? createdTime,
  }) =>
      Note(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        number: number ?? this.number,
        title: title ?? this.title,
        desprecation: desprecation ?? this.desprecation,
        createdTime: createdTime ?? this.createdTime,
      );
  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        isImportant: json[NoteFields.isImportant] == 1,
        number: json[NoteFields.number] as int,
        title: json[NoteFields.title] as String,
        desprecation: json[NoteFields.description] as String,
        createdTime: DateTime.parse(json[NoteFields.time] as String),

      );

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.number: number,
        NoteFields.title: title,
        NoteFields.isImportant: isImportant ? 1 : 0,
        NoteFields.description: desprecation,
        NoteFields.time: createdTime.toIso8601String(),
      };
}
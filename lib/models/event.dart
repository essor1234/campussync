class Event {
  final String id;
  final String attendees;
  final String title;
  final String dateTime;
  final String? description;

  Event({
    required this.id,
    required this.attendees,
    required this.title,
    required this.dateTime,
    this.description,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'attendees': attendees,
    'title': title,
    'dateTime': dateTime,
    'description': description,
  };

  factory Event.fromMap(Map<String, dynamic> map) => Event(
    id: map['id'],
    attendees: map['attendees'],
    title: map['title'],
    dateTime: map['dateTime'],
    description: map['description'],
  );
}

class Schedule {
  final String id;
  final String attendees;
  final String title;
  final String dateTime;
  final String? description;

  Schedule({
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

  factory Schedule.fromMap(Map<String, dynamic> map) => Schedule(
    id: map['id'],
    attendees: map['attendees'],
    title: map['title'],
    dateTime: map['dateTime'],
    description: map['description'],
  );
}

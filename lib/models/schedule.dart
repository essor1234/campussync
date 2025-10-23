class Schedule {
  final String id;
  final String userId;
  final String title;
  final String dateTime;
  final String? description;

  Schedule({
    required this.id,
    required this.userId,
    required this.title,
    required this.dateTime,
    this.description,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'userId': userId,
    'title': title,
    'dateTime': dateTime,
    'description': description,
  };

  factory Schedule.fromMap(Map<String, dynamic> map) => Schedule(
    id: map['id'],
    userId: map['userId'],
    title: map['title'],
    dateTime: map['dateTime'],
    description: map['description'],
  );
}

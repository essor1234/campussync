class Schedule {
  final String id;
  final String userid;
  final String title;
  final String dateTime;
  final String? description;

  Schedule({
    required this.id,
    required this.userid,
    required this.title,
    required this.dateTime,
    this.description,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'userid': userid,
    'title': title,
    'dateTime': dateTime,
    'description': description,
  };

  factory Schedule.fromMap(Map<String, dynamic> map) => Schedule(
    id: map['id'],
    userid: map['userid'],
    title: map['title'],
    dateTime: map['dateTime'],
    description: map['description'],
  );
}

class Reminder {
  final String title;
  final DateTime dateTime;
  
  Reminder({required this.title, required this.dateTime});

  Map<String, dynamic> toMap() {
    return {'title': title, 'dateTime': dateTime.toIso8601String()};
  }

  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder(
      title: map['title'],
      dateTime: DateTime.parse(map['dateTime']),
    );
  }
}

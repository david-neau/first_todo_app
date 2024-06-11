class Task {
  String title;
  DateTime dueDate;
  bool isCompleted;

  Task({required this.title, required this.dueDate, this.isCompleted = false});

  Task copyWith({
    String? title,
    DateTime? dueDate,
    bool? isCompleted,
  }) {
    return Task(
      title: title ?? this.title,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

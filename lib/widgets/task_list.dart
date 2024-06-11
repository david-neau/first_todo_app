import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final Function(Task) onToggle;
  final Function(Task) onDelete;

  const TaskList({
    Key? key,
    required this.tasks,
    required this.onToggle,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return ListTile(
          leading: Checkbox(
            value: task.isCompleted,
            onChanged: (newValue) => onToggle(task),
          ),
          title: Text(task.title),
          subtitle: Text('Due: ${DateFormat.yMMMd().format(task.dueDate)}'),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => onDelete(task),
          ),
        );
      },
    );
  }
}

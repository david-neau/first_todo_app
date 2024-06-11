import 'package:flutter/material.dart';
import 'task.dart';
import 'package:intl/intl.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final Function(Task) onToggle;

  const TaskList({Key? key, required this.tasks, required this.onToggle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return ListTile(
          title: Text(task.title),
          subtitle: Text('Due: ${DateFormat.yMMMd().format(task.dueDate)}'),
          trailing: IconButton(
            icon: Icon(Icons.check,
                color: task.isCompleted ? Colors.green : Colors.grey),
            onPressed: () => onToggle(task),
          ),
        );
      },
    );
  }
}

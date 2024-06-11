import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/task_list.dart';

class ArchivedTasks extends StatelessWidget {
  const ArchivedTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        final archivedTasks =
            taskProvider.tasks.where((task) => task.isCompleted).toList();
        return TaskList(
          tasks: archivedTasks,
          onToggle: taskProvider.toggleTaskCompletion,
          onDelete: taskProvider.removeTask,
        );
      },
    );
  }
}

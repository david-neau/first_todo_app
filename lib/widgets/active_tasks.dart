import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/task_list.dart';

class ActiveTasks extends StatelessWidget {
  const ActiveTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        final activeTasks =
            taskProvider.tasks.where((task) => !task.isCompleted).toList();
        return TaskList(
          tasks: activeTasks,
          onToggle: taskProvider.toggleTaskCompletion,
          onDelete: taskProvider.removeTask,
        );
      },
    );
  }
}

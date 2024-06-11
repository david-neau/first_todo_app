import 'package:flutter/material.dart';
import 'add_task_page.dart';
import 'task.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter TabBar Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TabbarExample(),
    );
  }
}

class TabbarExample extends StatefulWidget {
  const TabbarExample({super.key});

  @override
  State<TabbarExample> createState() => _TabbarExampleState();
}

class _TabbarExampleState extends State<TabbarExample> {
  final List<Task> tasks = [
    Task(title: 'Task 1', dueDate: DateTime.now().add(const Duration(days: 1))),
    Task(title: 'Task 2', dueDate: DateTime.now().add(const Duration(days: 2))),
  ];

  void addTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }

  void toggleTaskCompletion(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
      if (task.isCompleted) {
        // Move task to archived list
        tasks.remove(task);
        tasks.add(task);
      }
    });
  }

  void editTask(Task oldTask, Task newTask) {
    setState(() {
      final index = tasks.indexWhere((task) => task == oldTask);
      if (index != -1) {
        tasks[index] = newTask;
      }
    });
  }

  void removeTask(Task task) {
    setState(() {
      tasks.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("To Do"),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: "Active",
              ),
              Tab(
                icon: Icon(Icons.archive),
                text: "Archived",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: tasks.where((task) => !task.isCompleted).length,
              itemBuilder: (context, index) {
                final activeTasks =
                    tasks.where((task) => !task.isCompleted).toList();
                final task = activeTasks[index];
                return ListTile(
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (newValue) => toggleTaskCompletion(task),
                  ),
                  title: Text(task.title),
                  subtitle:
                      Text('Due: ${DateFormat.yMMMd().format(task.dueDate)}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => removeTask(task),
                  ),
                );
              },
            ),
            ListView.builder(
              itemCount: tasks.where((task) => task.isCompleted).length,
              itemBuilder: (context, index) {
                final archivedTasks =
                    tasks.where((task) => task.isCompleted).toList();
                final task = archivedTasks[index];
                return ListTile(
                  leading: Checkbox(
                    value: task.isCompleted,
                    onChanged: (newValue) => toggleTaskCompletion(task),
                  ),
                  title: Text(task.title),
                  subtitle:
                      Text('Due: ${DateFormat.yMMMd().format(task.dueDate)}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => removeTask(task),
                  ),
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddTaskPage(onAdd: addTask)),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

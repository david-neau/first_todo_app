import 'package:flutter/material.dart';
import '../widgets/active_tasks.dart';
import '../widgets/archived_tasks.dart';
import 'add_task_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("To Do"),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: "Active"),
              Tab(icon: Icon(Icons.archive), text: "Archived"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ActiveTasks(),
            ArchivedTasks(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTaskPage(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

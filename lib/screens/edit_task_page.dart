import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;

  const EditTaskPage({Key? key, required this.task}) : super(key: key);

  @override
  _EditTaskPageState createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late DateTime _dueDate;
  final _titleFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _dueDate = widget.task.dueDate;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _titleFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _titleFocusNode.dispose();
    _titleController.dispose();
    super.dispose();
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final updatedTask = widget.task.copyWith(
        title: _titleController.text,
        dueDate: _dueDate,
      );
      Provider.of<TaskProvider>(context, listen: false)
          .editTask(widget.task, updatedTask);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                focusNode: _titleFocusNode,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                title:
                    Text('Due Date: ${_dueDate.toLocal().toShortDateString()}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: _selectDueDate,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveTask,
        child: const Icon(Icons.save),
      ),
    );
  }

  Future<void> _selectDueDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _dueDate) {
      setState(() {
        _dueDate = picked;
      });
    }
  }
}

extension DateHelpers on DateTime {
  String toShortDateString() {
    return '${this.year}-${this.month.toString().padLeft(2, '0')}-${this.day.toString().padLeft(2, '0')}';
  }
}

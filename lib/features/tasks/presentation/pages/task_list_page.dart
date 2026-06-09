import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Tasks')),
      body: const Center(child: Text('Task List Coming Next!')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/addTask'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

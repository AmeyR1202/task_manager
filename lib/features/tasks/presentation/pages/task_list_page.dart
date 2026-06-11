import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/features/tasks/presentation/bloc/task_bloc.dart';
import 'package:task_manager/features/tasks/presentation/bloc/task_state.dart';
import 'package:task_manager/features/tasks/presentation/widgets/task_item_widget.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  String _currentFilter = 'All';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Tasks',
        ), // TODO: integrate some sort of filtering on the tasks later
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _currentFilter = value;
              });
            },
            icon: const Icon(Icons.filter_list),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'All', child: Text('All Tasks')),
              const PopupMenuItem(
                value: 'Pending',
                child: Text('Pending Tasks'),
              ),
              const PopupMenuItem(
                value: 'Completed',
                child: Text('Completed Tasks'),
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is TaskError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (state is TaskLoaded) {
            final filteredTasks = state.tasks.where((task) {
              if (_currentFilter == 'Completed') return task.isCompleted;
              if (_currentFilter == 'Pending') return task.isCompleted == false;
              return true; // allows the tasks to be present in one list (each & every task)
            }).toList();
            if (filteredTasks.isEmpty) {
              return const Center(
                child: Text(
                  'No Tasks found. Add a new one!',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return TaskItemWidget(task: task);
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/addTask'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

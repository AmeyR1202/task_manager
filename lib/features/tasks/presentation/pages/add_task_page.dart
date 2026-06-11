// lib/features/tasks/presentation/pages/add_task_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/core/theme/app_theme.dart';
import 'package:task_manager/features/tasks/domain/entities/task_entity.dart';
import 'package:task_manager/features/tasks/presentation/bloc/task_bloc.dart';
import 'package:task_manager/features/tasks/presentation/bloc/task_event.dart';
import 'package:task_manager/features/tasks/presentation/widgets/priority_button_widget.dart';
import 'package:uuid/uuid.dart';

class AddTaskPage extends StatefulWidget {
  final TaskEntity? existingTask;

  const AddTaskPage({super.key, this.existingTask});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  @override
  void initState() {
    super.initState();
    if (widget.existingTask != null) {
      title = widget.existingTask!.title;
      description = widget.existingTask!.description ?? '';
      selectedPriority = widget.existingTask!.priority;
      selectedDueDate = widget
          .existingTask!
          .dueDate; // Make sure to retain existing due date!
    }
  }

  final _formKey = GlobalKey<FormState>();
  DateTime? selectedDueDate;
  TaskPriority selectedPriority = TaskPriority.medium;

  Future<void> _selectDueDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null) return;

    if (!mounted) return;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    setState(() {
      selectedDueDate = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    });
  }

  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    final dueDate = selectedDueDate ?? widget.existingTask?.dueDate;
    return Scaffold(
      appBar: AppBar(title: const Text('Create new task')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: widget.existingTask?.title,
                  decoration: const InputDecoration(
                    hintText: "Name",
                    hintStyle: TextStyle(color: AppTheme.textSecondary),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                  onChanged: (val) => title = val,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: widget.existingTask?.description,
                  maxLines: 5,
                  minLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                    hintStyle: TextStyle(color: AppTheme.textSecondary),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (val) => description = val,
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: _selectDueDate,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            dueDate == null
                                ? 'Select Due Date'
                                : '${dueDate.day}/${dueDate.month}/${dueDate.year} - ${dueDate.hour}:${dueDate.minute}',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text("Priority"),
                const SizedBox(height: 10),
                Row(
                  children: [
                    PriorityButton(
                      text: "Low",
                      isSelected: selectedPriority == TaskPriority.low,
                      onTap: () {
                        setState(() {
                          selectedPriority = TaskPriority.low;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    PriorityButton(
                      text: "Medium",
                      isSelected: selectedPriority == TaskPriority.medium,
                      onTap: () {
                        setState(() {
                          selectedPriority = TaskPriority.medium;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    PriorityButton(
                      text: "High",
                      isSelected: selectedPriority == TaskPriority.high,
                      onTap: () {
                        setState(() {
                          selectedPriority = TaskPriority.high;
                        });
                      },
                    ),
                  ],
                ),

                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final task = TaskEntity(
                          id: widget.existingTask?.id ?? const Uuid().v4(),
                          title: title,
                          description: description,
                          dueDate: selectedDueDate,
                          priority: selectedPriority, // ADDED THIS BACK
                          isCompleted:
                              widget.existingTask?.isCompleted ?? false,
                        );

                        context.read<TaskBloc>().add(
                          widget.existingTask == null
                              ? AddNewTaskEvent(task)
                              : UpdateExistingTaskEvent(task),
                        );
                        context.pop();
                      }
                    },
                    child: Text(
                      widget.existingTask == null
                          ? 'Create Task'
                          : 'Update Task',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

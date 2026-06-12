// lib/features/tasks/presentation/widgets/task_item_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/core/theme/app_theme.dart';
import 'package:task_manager/features/tasks/domain/entities/task_entity.dart';
import 'package:task_manager/features/tasks/presentation/bloc/task_bloc.dart';
import 'package:task_manager/features/tasks/presentation/bloc/task_event.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskEntity task;

  const TaskItemWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/addTask', extra: task);
      },
      child: Dismissible(
        key: Key(task.id),
        direction: DismissDirection.endToStart,
        background: Container(
          margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Icon(
            Icons.delete_outline,
            color: Colors.white,
            size: 28,
          ),
        ),
        onDismissed: (direction) {
          final taskBloc = context.read<TaskBloc>();
          taskBloc.add(DeleteExistingTaskEvent(task.id));

          final messenger = ScaffoldMessenger.of(context);
          
          messenger.clearSnackBars();
          messenger.showSnackBar(
            SnackBar(
              content: const Text('Task deleted'),
              duration: const Duration(seconds: 3),
              action: SnackBarAction(
                label: 'UNDO',
                onPressed: () {
                  taskBloc.add(AddNewTaskEvent(task));
                },
              ),
            ),
          );

          Future.delayed(const Duration(seconds: 3), () {
            messenger.hideCurrentSnackBar();
          });
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          height: 80,
          decoration: BoxDecoration(
            color: AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // the starting color part of the tile
              Container(
                width: 14,
                decoration: BoxDecoration(
                  color: _getPriorityColor(task.priority),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                          decorationColor: AppTheme.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      if (task.dueDate != null)
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month_sharp,
                              size: 14,
                              color: AppTheme.textPrimary,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              DateFormat('d MMM').format(task.dueDate!),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              //circular checkbox
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () {
                    final updatedTask = task.copyWith(
                      isCompleted: !task.isCompleted,
                    );
                    context.read<TaskBloc>().add(
                      UpdateExistingTaskEvent(updatedTask),
                    );
                  },
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: task.isCompleted
                          ? AppTheme.primaryPurple
                          : Colors.transparent,
                      border: Border.all(
                        color: AppTheme.primaryPurple,
                        width: 2,
                      ),
                    ),
                    child: task.isCompleted
                        ? const Icon(Icons.check, size: 18, color: Colors.black)
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return AppTheme.errorColor.withValues(alpha: 0.5);
      case TaskPriority.medium:
        return AppTheme.warningColor.withValues(alpha: 0.5);
      case TaskPriority.low:
        return AppTheme.successColor.withValues(alpha: 0.5);
    }
  }
}

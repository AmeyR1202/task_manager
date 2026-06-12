import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_theme.dart';
import 'package:task_manager/features/tasks/domain/entities/task_entity.dart';
import 'package:task_manager/features/tasks/presentation/widgets/priority_button_widget.dart';

class PrioritySelectorWidget extends StatelessWidget {
  final TaskPriority selectedPriority;
  final ValueChanged<TaskPriority> onPriorityChanged;

  const PrioritySelectorWidget({
    super.key,
    required this.selectedPriority,
    required this.onPriorityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Priority"),
        const SizedBox(height: 10),
        Row(
          children: [
            PriorityButton(
              text: "Low",
              isSelected: selectedPriority == TaskPriority.low,
              selectedColor: AppTheme.successColor,
              onTap: () => onPriorityChanged(TaskPriority.low),
            ),
            const SizedBox(width: 8),
            PriorityButton(
              text: "Medium",
              isSelected: selectedPriority == TaskPriority.medium,
              selectedColor: AppTheme.warningColor,
              onTap: () => onPriorityChanged(TaskPriority.medium),
            ),
            const SizedBox(width: 8),
            PriorityButton(
              text: "High",
              isSelected: selectedPriority == TaskPriority.high,
              selectedColor: AppTheme.errorColor,
              onTap: () => onPriorityChanged(TaskPriority.high),
            ),
          ],
        ),
      ],
    );
  }
}

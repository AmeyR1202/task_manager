import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_theme.dart';

class DatePickerTileWidget extends StatelessWidget {
  final DateTime? dueDate;
  final VoidCallback onTap;

  const DatePickerTileWidget({
    super.key,
    required this.dueDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                    : '${dueDate?.day}/${dueDate?.month}/${dueDate?.year} - ${dueDate?.hour}:${dueDate?.minute}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

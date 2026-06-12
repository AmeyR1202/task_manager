import 'package:flutter/material.dart';

class PriorityButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final Color selectedColor;

  const PriorityButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 56,
          decoration: BoxDecoration(
            color: isSelected
                ? selectedColor.withValues(alpha: 0.15)
                : const Color(0xFF151515),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? selectedColor.withValues(alpha: 0.5)
                  : Colors.transparent,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected ? selectedColor : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

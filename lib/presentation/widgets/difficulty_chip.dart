import 'package:flutter/material.dart';
import 'package:leet/core/theme/app_theme.dart';

class DifficultyChip extends StatelessWidget {
  final String difficulty;

  const DifficultyChip({
    super.key,
    required this.difficulty,
  });

  @override
  Widget build(BuildContext context) {
    final color = _getDifficultyColor(difficulty);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        difficulty,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return AppTheme.easyColor;
      case 'medium':
        return AppTheme.mediumColor;
      case 'hard':
        return AppTheme.hardColor;
      default:
        return AppTheme.textSecondary;
    }
  }
}

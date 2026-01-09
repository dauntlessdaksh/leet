import 'package:flutter/material.dart';
import 'package:leet/core/theme/app_theme.dart';

class QuestionsFilterModal extends StatefulWidget {
  final String? selectedDifficulty;
  final String? selectedStatus;
  final Function(String?, String?) onApply;

  const QuestionsFilterModal({
    super.key,
    this.selectedDifficulty,
    this.selectedStatus,
    required this.onApply,
  });

  @override
  State<QuestionsFilterModal> createState() => _QuestionsFilterModalState();
}

class _QuestionsFilterModalState extends State<QuestionsFilterModal> {
  String? _difficulty;
  String? _status;

  @override
  void initState() {
    super.initState();
    _difficulty = widget.selectedDifficulty;
    _status = widget.selectedStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Filter Questions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 24),
          const Text('Difficulty', style: TextStyle(color: AppTheme.textSecondary)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            children: ['Easy', 'Medium', 'Hard'].map((diff) {
              final isSelected = _difficulty == diff;
              return FilterChip(
                label: Text(diff),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _difficulty = selected ? diff : null;
                  });
                },
                backgroundColor: AppTheme.bgNeutral,
                selectedColor: AppTheme.primaryColor,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.black : AppTheme.textPrimary,
                ),
                checkmarkColor: Colors.black,
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          const Text('Status', style: TextStyle(color: AppTheme.textSecondary)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            children: ['ac', 'notac', 'todo'].map((stat) {
              final label = stat == 'ac' ? 'Solved' : (stat == 'notac' ? 'Unsolved' : 'Todo');
              final isSelected = _status == stat;
              return FilterChip(
                label: Text(label),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _status = selected ? stat : null;
                  });
                },
                backgroundColor: AppTheme.bgNeutral,
                selectedColor: AppTheme.primaryColor,
                labelStyle: TextStyle(
                    color: isSelected ? Colors.black : AppTheme.textPrimary),
                checkmarkColor: Colors.black,
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              widget.onApply(_difficulty, _status);
              Navigator.pop(context);
            },
            child: const Text('Apply Filters'),
          ),
        ],
      ),
    );
  }
}

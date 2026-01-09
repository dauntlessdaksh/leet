import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leet/core/theme/app_theme.dart';
import 'package:leet/data/models/daily_challenge_model.dart';
import 'package:leet/presentation/widgets/difficulty_chip.dart';

class ProblemOfTheDayCard extends StatelessWidget {
  final DailyChallenge challenge;
  final String date;
  final VoidCallback onTap;

  const ProblemOfTheDayCard({
    super.key,
    required this.challenge,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Parse date if possible or use provided string
    DateTime? parsedDate;
    try {
      parsedDate = DateTime.parse(date);
    } catch (_) {}

    final formattedDate = parsedDate != null
        ? DateFormat('MMMM d, yyyy').format(parsedDate)
        : date;

    final isSolved = challenge.userStatus == 'Finish';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppTheme.primaryBlue.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  color: AppTheme.textSecondary,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Problem of the Day',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const Spacer(),
                if (isSolved)
                  const Icon(
                    Icons.check_circle,
                    color: AppTheme.easyColor,
                    size: 20,
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              formattedDate,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              challenge.question?.title ?? 'Unknown Problem',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                DifficultyChip(difficulty: challenge.question?.difficulty ?? 'Easy'),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBlue.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: AppTheme.primaryBlue,
                    size: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

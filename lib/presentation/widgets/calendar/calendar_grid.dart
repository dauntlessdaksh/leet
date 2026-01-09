import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leet/core/theme/app_theme.dart';
import 'package:leet/data/models/daily_challenge_model.dart';
import 'package:leet/presentation/widgets/difficulty_chip.dart';

class CalendarGrid extends StatelessWidget {
  final DateTime currentMonth;
  final Map<DateTime, DailyChallenge> dailyChallenges;
  final Function(DailyChallenge) onDateClick;
  final VoidCallback onNextMonth;
  final VoidCallback onPreviousMonth;

  const CalendarGrid({
    super.key,
    required this.currentMonth,
    required this.dailyChallenges,
    required this.onDateClick,
    required this.onNextMonth,
    required this.onPreviousMonth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.primaryBlue.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: 16),
          _buildDayOfWeekHeader(context),
          const SizedBox(height: 8),
          _buildGrid(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: onPreviousMonth,
          icon: const Icon(Icons.chevron_left, color: AppTheme.primaryBlue),
        ),
        Column(
          children: [
            Text(
              DateFormat('MMMM').format(currentMonth),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              DateFormat('yyyy').format(currentMonth),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
            ),
          ],
        ),
        IconButton(
          onPressed: onNextMonth,
          icon: const Icon(Icons.chevron_right, color: AppTheme.primaryBlue),
        ),
      ],
    );
  }

  Widget _buildDayOfWeekHeader(BuildContext context) {
    final days = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: days.map((day) => Expanded(
        child: Center(
          child: Text(
            day,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary.withOpacity(0.5),
                ),
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildGrid(BuildContext context) {
    final daysInMonth = DateUtils.getDaysInMonth(currentMonth.year, currentMonth.month);
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final firstWeekday = firstDayOfMonth.weekday % 7; // Sunday is 0 with this modulo

    final totalCells = (daysInMonth + firstWeekday + 6) ~/ 7 * 7;
    
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: totalCells,
      itemBuilder: (context, index) {
        if (index < firstWeekday || index >= firstWeekday + daysInMonth) {
          return const SizedBox();
        }

        final day = index - firstWeekday + 1;
        final date = DateTime(currentMonth.year, currentMonth.month, day);
        // Normalize date for map lookup (remove time)
        final dateKey = DateTime(date.year, date.month, date.day);
        
        // Find challenge by date string matching "yyyy-MM-dd"
        // Since our key in map is DateTime, we need to iterate or ensure keys are normalized.
        // Assuming keys passed in are normalized dates.
        final challenge = _findChallengeForDate(date);
        final isToday = DateUtils.isSameDay(date, DateTime.now());

        return _buildDayCell(context, day, isToday, challenge);
      },
    );
  }

  DailyChallenge? _findChallengeForDate(DateTime date) {
    // Map in BLoC state might be string or DateTime. Checking state...
    // State has dailyCodingChallengeV2.challenges list. 
    // We should probably convert list to map for easier lookup in parent or here.
    // For now, doing simple list search (O(N) for each cell, N=30, logic is fine)
    
    // Oh wait, `dailyChallenges` passed to this widget is Map<DateTime, Challenge>.
    // So we need to ensure keys match.
    for (var key in dailyChallenges.keys) {
      if (DateUtils.isSameDay(key, date)) {
        return dailyChallenges[key];
      }
    }
    return null;
  }

  Widget _buildDayCell(BuildContext context, int day, bool isToday, DailyChallenge? challenge) {
    final hasQuestion = challenge != null;
    final isSolved = challenge?.userStatus == 'Finish';

    Color borderColor = Colors.transparent;
    Color backgroundColor = AppTheme.bgNeutral.withOpacity(0.3);
    Color textColor = AppTheme.textSecondary;

    if (isToday) {
      borderColor = AppTheme.primaryBlue;
      textColor = AppTheme.primaryBlue;
      backgroundColor = AppTheme.primaryBlue.withOpacity(0.1);
    } 

    if (hasQuestion) {
       // Difficulty border if not today (or override?)
       // Android app: Today gets blue border. Question difficulty determines dot color.
       
       if (!isToday) {
         backgroundColor = AppTheme.cardBackground; // Or lighter
       }
       textColor = AppTheme.textPrimary;
    }

    Color? dotColor;
    if (hasQuestion) {
      switch (challenge!.question?.difficulty) {
        case 'Easy':
          dotColor = AppTheme.easyColor;
          break;
        case 'Medium':
          dotColor = AppTheme.mediumColor;
          break;
        case 'Hard':
          dotColor = AppTheme.hardColor;
          break;
        default:
          dotColor = AppTheme.easyColor;
      }
      if (isSolved) {
         // Maybe different visual for solved? Android app just uses dot color.
      }
    }

    return GestureDetector(
      onTap: hasQuestion ? () => onDateClick(challenge!) : null,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: borderColor,
            width: isToday ? 2 : 0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$day',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: textColor,
                    fontWeight: isToday || hasQuestion ? FontWeight.bold : FontWeight.normal,
                  ),
            ),
            if (hasQuestion)
              Container(
                margin: const EdgeInsets.only(top: 2),
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

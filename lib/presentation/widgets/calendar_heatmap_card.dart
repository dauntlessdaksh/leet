import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:leet/core/theme/app_theme.dart';
import 'package:leet/presentation/widgets/custom_card.dart';
import 'dart:convert';

class CalendarHeatmapCard extends StatelessWidget {
  final String? submissionCalendar; // JSON string from API: {"1698278400": 3, ...}
  final int activeYears;
  final int totalActiveDays;
  final int streak;

  const CalendarHeatmapCard({
    super.key,
    required this.submissionCalendar,
    required this.activeYears,
    required this.totalActiveDays,
    required this.streak,
  });

  @override
  Widget build(BuildContext context) {
    // Parse submissionCalendar
    Map<DateTime, int> datasets = {};
    if (submissionCalendar != null && submissionCalendar!.isNotEmpty) {
      try {
        final Map<String, dynamic> json = jsonDecode(submissionCalendar!);
        json.forEach((key, value) {
          final timestamp = int.parse(key);
          final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
          datasets[DateTime(date.year, date.month, date.day)] = value as int;
        });
      } catch (e) {
        // Handle parsing error
      }
    }

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Flexible(
                child: Text(
                  'Submission Activity',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.local_fire_department, color: AppTheme.primaryColor, size: 20),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        '$streak Day Streak',
                        style: const TextStyle(
                          color: AppTheme.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          HeatMap(
            datasets: datasets,
            colorMode: ColorMode.color,
            showText: false,
            scrollable: true,
            showColorTip: false,
            colorsets: const {
               1: Color(0x59FFC01E), // 35% opacity - very light yellow
               2: Color(0x99FFC01E), // 60% opacity - medium light yellow
               3: Color(0xCCFFC01E), // 80% opacity - bright yellow
               4: Color(0xFFFFC01E), // 100% opacity - full bright yellow
            },
            onClick: (value) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Submissions: ${datasets[value] ?? 0} on ${value.toString().split(' ')[0]}'))
              );
            },
            startDate: DateTime.now().subtract(const Duration(days: 365)),
            endDate: DateTime.now(),
            size: 18,
            fontSize: 12,
            defaultColor: AppTheme.bgNeutral,
            textColor: AppTheme.textSecondary,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text(
                'Less',
                style: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
              ),
              const SizedBox(width: 8),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: AppTheme.bgNeutral,
                  border: Border.all(color: AppTheme.textSecondary.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: const Color(0x59FFC01E),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: const Color(0x99FFC01E),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: const Color(0xCCFFC01E),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFC01E),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'More',
                style: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Total Active Days: $totalActiveDays',
             style: const TextStyle(color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }
}

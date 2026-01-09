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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Submission Activity',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              Row(
                children: [
                   const Icon(Icons.local_fire_department, color: AppTheme.primaryColor, size: 20),
                   const SizedBox(width: 4),
                   Text(
                     '$streak Day Streak',
                     style: const TextStyle(
                       color: AppTheme.textPrimary,
                       fontWeight: FontWeight.bold,
                     ),
                   ),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          HeatMap(
            datasets: datasets,
            colorMode: ColorMode.opacity,
            showText: false,
            scrollable: true,
            colorsets: const {
               1: AppTheme.primaryColor,
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
          Text(
            'Total Active Days: $totalActiveDays',
             style: const TextStyle(color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }
}

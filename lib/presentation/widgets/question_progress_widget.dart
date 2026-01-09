import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:leet/core/theme/app_theme.dart';
import 'package:leet/data/models/user_stats_model.dart';
import 'package:leet/data/models/user_model.dart';
import 'package:leet/presentation/widgets/custom_card.dart';

class QuestionProgressCard extends StatelessWidget {
  final UserQuestionStatusData? userStats;

  const QuestionProgressCard({
    super.key,
    required this.userStats,
  });

  @override
  Widget build(BuildContext context) {
    if (userStats == null) return const SizedBox();

    final acSubmissionNum = userStats!.matchedUser!.submitStats!.acSubmissionNum!;
    final totalSubmissionNum = userStats!.allQuestionsCount!;

    // Find counts (Easy, Medium, Hard, All)
    // API returns list, usually [All, Easy, Medium, Hard]
    // Let's protect against index errors by finding by difficulty name
    
    int getSolved(String diff) => acSubmissionNum.firstWhere(
        (e) => e.difficulty == diff, orElse: () => DifficultyCount(count: 0)).count ?? 0;
        
    int getTotal(String diff) => totalSubmissionNum.firstWhere(
        (e) => e.difficulty == diff, orElse: () => AllQuestionsCount(count: 1)).count ?? 1;

    final easySolved = getSolved('Easy');
    final mediumSolved = getSolved('Medium');
    final hardSolved = getSolved('Hard');
    final allSolved = getSolved('All');
    
    final allTotal = getTotal('All');

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Solved Problems',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              // Circular Chart
              SizedBox(
                width: 120,
                height: 120,
                child: Stack(
                  children: [
                    PieChart(
                      PieChartData(
                        sectionsSpace: 0,
                        centerSpaceRadius: 40,
                        sections: [
                          PieChartSectionData(
                            color: AppTheme.easyColor,
                            value: easySolved.toDouble(),
                            title: '',
                            radius: 8,
                          ),
                          PieChartSectionData(
                            color: AppTheme.mediumColor,
                            value: mediumSolved.toDouble(),
                            title: '',
                            radius: 8,
                          ),
                          PieChartSectionData(
                            color: AppTheme.hardColor,
                            value: hardSolved.toDouble(),
                            title: '',
                            radius: 8,
                          ),
                          PieChartSectionData(
                            color: AppTheme.bgNeutral, // Remaining
                            value: (allTotal - allSolved).toDouble(),
                            title: '',
                            radius: 6,
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'All',
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            '$allSolved',
                            style: const TextStyle(
                              color: AppTheme.textPrimary,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              // Legend
              Expanded(
                child: Column(
                  children: [
                    _buildLegendItem('Easy', easySolved, getTotal('Easy'), AppTheme.easyColor),
                    const SizedBox(height: 12),
                    _buildLegendItem('Medium', mediumSolved, getTotal('Medium'), AppTheme.mediumColor),
                    const SizedBox(height: 12),
                    _buildLegendItem('Hard', hardSolved, getTotal('Hard'), AppTheme.hardColor),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, int solved, int total, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ), // Color dot
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(color: AppTheme.textSecondary),
        ),
        const Spacer(),
        Text(
          '$solved',
          style: const TextStyle(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '/$total',
          style: const TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

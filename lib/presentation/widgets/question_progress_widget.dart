import 'package:flutter/material.dart';
import 'package:leet/core/theme/app_theme.dart';
import 'package:leet/data/models/user_model.dart';
import 'package:leet/data/models/user_stats_model.dart';
import 'dart:math' as math;

class QuestionProgressCard extends StatelessWidget {
  final UserQuestionStatusData? userStats;

  const QuestionProgressCard({
    super.key,
    required this.userStats,
  });

  @override
  Widget build(BuildContext context) {
    if (userStats == null) return const SizedBox();

    final acSubmissionNum =
        userStats!.matchedUser!.submitStats!.acSubmissionNum!;
    final totalSubmissionNum = userStats!.allQuestionsCount!;

    int getSolved(String diff) =>
        acSubmissionNum
            .firstWhere((e) => e.difficulty == diff,
                orElse: () => DifficultyCount(count: 0))
            .count ??
        0;

    int getTotal(String diff) =>
        totalSubmissionNum
            .firstWhere((e) => e.difficulty == diff,
                orElse: () => AllQuestionsCount(count: 1))
            .count ??
        1;

    final easySolved = getSolved('Easy');
    final mediumSolved = getSolved('Medium');
    final hardSolved = getSolved('Hard');
    final allSolved = getSolved('All');

    final easyTotal = getTotal('Easy');
    final mediumTotal = getTotal('Medium');
    final hardTotal = getTotal('Hard');
    final allTotal = getTotal('All');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final chartSize = constraints.maxWidth < 350 ? 100.0 : 120.0;
          final spacing = constraints.maxWidth < 350 ? 16.0 : 24.0;
          
          return Row(
            children: [
              SizedBox(
                width: chartSize,
                height: chartSize,
                child: CustomPaint(
                  painter: StatisticsCirclePainter(
                    easySolved: easySolved,
                    mediumSolved: mediumSolved,
                    hardSolved: hardSolved,
                    easyTotal: easyTotal,
                    mediumTotal: mediumTotal,
                    hardTotal: hardTotal,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$allSolved',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: chartSize < 110 ? 24 : 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '/ $allTotal',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: spacing),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildStatRow(
                        'Easy', easySolved, easyTotal, const Color(0xFF00C853)),
                    const SizedBox(height: 12),
                    _buildStatRow(
                        'Med', mediumSolved, mediumTotal, const Color(0xFFFFD600)),
                    const SizedBox(height: 12),
                    _buildStatRow(
                        'Hard', hardSolved, hardTotal, const Color(0xFFFF5252)),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatRow(String label, int solved, int total, Color color) {
    return Row(
      children: [
        SizedBox(
          width: 50,
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '$solved / $total',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class StatisticsCirclePainter extends CustomPainter {
  final int easySolved;
  final int mediumSolved;
  final int hardSolved;
  final int easyTotal;
  final int mediumTotal;
  final int hardTotal;

  StatisticsCirclePainter({
    required this.easySolved,
    required this.mediumSolved,
    required this.hardSolved,
    required this.easyTotal,
    required this.mediumTotal,
    required this.hardTotal,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 10;

    final totalProblems = easyTotal + mediumTotal + hardTotal;

    if (totalProblems == 0) {
      return;
    }

    // Calculate the proportion of each difficulty in total problems
    final easyProportion = easyTotal / totalProblems;
    final mediumProportion = mediumTotal / totalProblems;
    final hardProportion = hardTotal / totalProblems;

    // Calculate angles for each section (based on total problems)
    final easyTotalAngle = easyProportion * 2 * math.pi;
    final mediumTotalAngle = mediumProportion * 2 * math.pi;
    final hardTotalAngle = hardProportion * 2 * math.pi;

    // Calculate solved angles within each section
    final easySolvedAngle =
        easyTotal > 0 ? (easySolved / easyTotal) * easyTotalAngle : 0.0;
    final mediumSolvedAngle =
        mediumTotal > 0 ? (mediumSolved / mediumTotal) * mediumTotalAngle : 0.0;
    final hardSolvedAngle =
        hardTotal > 0 ? (hardSolved / hardTotal) * hardTotalAngle : 0.0;

    const gapAngle = 0.03; // Small gap between sections
    const startAngle = -math.pi / 2; // Start from top

    // Easy section
    double currentAngle = startAngle;

    // Draw Easy background (light green)
    if (easyTotal > 0) {
      final easyBgPaint = Paint()
        ..color = AppTheme.easyColor.withOpacity(0.2) // Light green
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        currentAngle,
        easyTotalAngle - gapAngle,
        false,
        easyBgPaint,
      );

      // Draw Easy solved (vibrant green) on top
      if (easySolved > 0) {
        final easySolvedPaint = Paint()
          ..color = AppTheme.easyColor // Vibrant green
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10
          ..strokeCap = StrokeCap.round;

        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          currentAngle,
          easySolvedAngle - gapAngle,
          false,
          easySolvedPaint,
        );
      }
    }

    currentAngle += easyTotalAngle;

    // Medium section
    if (mediumTotal > 0) {
      final mediumBgPaint = Paint()
        ..color = AppTheme.mediumColor.withOpacity(0.2) // Light yellow
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        currentAngle,
        mediumTotalAngle - gapAngle,
        false,
        mediumBgPaint,
      );

      // Draw Medium solved (vibrant yellow) on top
      if (mediumSolved > 0) {
        final mediumSolvedPaint = Paint()
          ..color = AppTheme.mediumColor // Vibrant yellow
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10
          ..strokeCap = StrokeCap.round;

        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          currentAngle,
          mediumSolvedAngle - gapAngle,
          false,
          mediumSolvedPaint,
        );
      }
    }

    currentAngle += mediumTotalAngle;

    // Hard section
    if (hardTotal > 0) {
      final hardBgPaint = Paint()
        ..color = AppTheme.hardColor.withOpacity(0.2) // Light red
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        currentAngle,
        hardTotalAngle - gapAngle,
        false,
        hardBgPaint,
      );

      // Draw Hard solved (vibrant red) on top
      if (hardSolved > 0) {
        final hardSolvedPaint = Paint()
          ..color = AppTheme.hardColor // Vibrant red
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10
          ..strokeCap = StrokeCap.round;

        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          currentAngle,
          hardSolvedAngle - gapAngle,
          false,
          hardSolvedPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant StatisticsCirclePainter oldDelegate) {
    return easySolved != oldDelegate.easySolved ||
        mediumSolved != oldDelegate.mediumSolved ||
        hardSolved != oldDelegate.hardSolved ||
        easyTotal != oldDelegate.easyTotal ||
        mediumTotal != oldDelegate.mediumTotal ||
        hardTotal != oldDelegate.hardTotal;
  }
}

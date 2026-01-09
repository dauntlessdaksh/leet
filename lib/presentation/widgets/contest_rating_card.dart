import 'package:flutter/material.dart';
import 'package:leet/core/theme/app_theme.dart';
import 'package:leet/data/models/contest_model.dart';
import 'dart:math' as math;

class ContestRatingCard extends StatelessWidget {
  final ContestRatingHistogramResponse? histogramData;
  final UserContestRankingResponse? userRanking;

  const ContestRatingCard({
    super.key,
    required this.histogramData,
    required this.userRanking,
  });

  @override
  Widget build(BuildContext context) {
    if (histogramData == null || 
        userRanking == null ||
        histogramData!.data == null ||
        userRanking!.data == null) {
      return const SizedBox.shrink();
    }

    final histogram = histogramData!.data!.contestRatingHistogram ?? [];
    final userRating = userRanking!.data!.userContestRanking?.rating ?? 0.0;
    final topPercentage = userRanking!.data!.userContestRanking?.topPercentage ?? 0.0;

    // Find the rating slab the user falls into
    final userSlab = histogram.firstWhere(
      (entry) => userRating >= (entry.ratingStart ?? 0) && userRating < (entry.ratingEnd ?? 0),
      orElse: () => histogram.isNotEmpty ? histogram.first : ContestRatingHistogramItem(),
    );

    return Container(
      padding: const EdgeInsets.all(20),
      height: 320,
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.cardBg,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              Text(
                '${userSlab.ratingStart ?? 0} - ${userSlab.ratingEnd ?? 0}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Percentage and user count row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${topPercentage.toStringAsFixed(2)} %',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                '${userSlab.userCount ?? 0} users',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Histogram chart
          Expanded(
            child: CustomPaint(
              painter: HistogramPainter(
                histogram: histogram,
                userRating: userRating,
              ),
              child: Container(),
            ),
          ),
        ],
      ),
    );
  }
}

class HistogramPainter extends CustomPainter {
  final List<ContestRatingHistogramItem> histogram;
  final double userRating;

  HistogramPainter({
    required this.histogram,
    required this.userRating,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (histogram.isEmpty) return;

    // Find max user count, handling nulls
    final userCounts = histogram.map((e) => e.userCount ?? 0).toList();
    final maxUserCount = userCounts.isEmpty ? 1.0 : userCounts.reduce(math.max).toDouble();
    final barWidth = (size.width / histogram.length) - 10;

    for (int i = 0; i < histogram.length; i++) {
      final entry = histogram[i];
      final userCount = (entry.userCount ?? 0).toDouble();
      final ratingStart = entry.ratingStart ?? 0;
      final ratingEnd = entry.ratingEnd ?? 0;

      // Check if user's rating falls in this range
      final isUserBar = userRating >= ratingStart && userRating < ratingEnd;

      // Calculate bar height (minimum 35px)
      final barHeight = math.max(35.0, (userCount / maxUserCount) * size.height * 0.8);

      final paint = Paint()
        ..color = isUserBar ? AppTheme.primaryColor : AppTheme.cardBg
        ..style = PaintingStyle.fill;

      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
          i * (size.width / histogram.length),
          size.height - barHeight,
          barWidth,
          barHeight,
        ),
        const Radius.circular(12),
      );

      canvas.drawRRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant HistogramPainter oldDelegate) {
    return histogram != oldDelegate.histogram || userRating != oldDelegate.userRating;
  }
}

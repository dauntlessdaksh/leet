import 'package:flutter/material.dart';
import 'package:leet/core/theme/app_theme.dart';
import 'package:leet/data/models/question_model.dart';
import 'package:leet/presentation/widgets/custom_card.dart';

class QuestionListTile extends StatelessWidget {
  final Question question;
  final VoidCallback onTap;

  const QuestionListTile({
    super.key,
    required this.question,
    required this.onTap,
  });

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Easy':
        return AppTheme.easyColor;
      case 'Medium':
        return AppTheme.mediumColor;
      case 'Hard':
        return AppTheme.hardColor;
      default:
        return AppTheme.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: CustomCard(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${question.frontendQuestionId}. ${question.title}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (question.paidOnly)
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.lock, size: 16, color: AppTheme.mediumColor),
                  ),
                if (question.status == 'ac')
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.check_circle, size: 16, color: AppTheme.easyColor),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getDifficultyColor(question.difficulty).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    question.difficulty,
                    style: TextStyle(
                      color: _getDifficultyColor(question.difficulty),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'AC Rate: ${question.acRate.toStringAsFixed(1)}%',
                   style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                ),
              ],
            ),
            if (question.topicTags.isNotEmpty) ...[
              const SizedBox(height: 8),
              SizedBox(
                height: 24,
                 child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: question.topicTags.length > 3 ? 3 : question.topicTags.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final tag = question.topicTags[index];
                    return Container(
                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                       decoration: BoxDecoration(
                         color: AppTheme.cardBg, // Slightly different
                         borderRadius: BorderRadius.circular(12),
                         border: Border.all(color: Colors.grey[800]!),
                       ),
                       child: Text(
                         tag.name,
                         style: const TextStyle(color: AppTheme.textSecondary, fontSize: 10),
                       ),
                    );
                  },
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}

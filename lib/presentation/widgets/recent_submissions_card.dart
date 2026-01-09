import 'package:flutter/material.dart';
import 'package:leet/core/theme/app_theme.dart';
import 'package:leet/data/models/submission_model.dart';
import 'package:leet/presentation/screens/question_details/question_details_screen.dart';

class RecentSubmissionsCard extends StatelessWidget {
  final UserRecentAcSubmissionResponse? submissions;

  const RecentSubmissionsCard({
    super.key,
    required this.submissions,
  });

  String _formatTimeDifference(int timestamp) {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final diffSeconds = now - timestamp;

    if (diffSeconds < 60) return 'just now';
    if (diffSeconds < 3600) {
      final minutes = diffSeconds ~/ 60;
      return '$minutes minute${minutes > 1 ? 's' : ''} ago';
    }
    if (diffSeconds < 86400) {
      final hours = diffSeconds ~/ 3600;
      return '$hours hour${hours > 1 ? 's' : ''} ago';
    }
    if (diffSeconds < 2592000) {
      final days = diffSeconds ~/ 86400;
      return '$days day${days > 1 ? 's' : ''} ago';
    }
    if (diffSeconds < 31536000) {
      final months = diffSeconds ~/ 2592000;
      return '$months month${months > 1 ? 's' : ''} ago';
    }
    final years = diffSeconds ~/ 31536000;
    return '$years year${years > 1 ? 's' : ''} ago';
  }

  @override
  Widget build(BuildContext context) {
    if (submissions == null || 
        submissions!.data == null || 
        submissions!.data!.recentAcSubmissionList == null ||
        submissions!.data!.recentAcSubmissionList!.isEmpty) {
      return const SizedBox.shrink();
    }

    final submissionsList = submissions!.data!.recentAcSubmissionList!;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.cardBg,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Submissions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 400, // Fixed height for scrollable list
            child: ListView.builder(
              itemCount: submissionsList.length,
              itemBuilder: (context, index) {
                final submission = submissionsList[index];
                
                // Parse timestamp
                int timestamp;
                try {
                  if (submission.timestamp is String) {
                    timestamp = int.parse(submission.timestamp as String);
                  } else if (submission.timestamp is int) {
                    timestamp = submission.timestamp as int;
                  } else {
                    timestamp = 0;
                  }
                } catch (e) {
                  timestamp = 0;
                }

                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        if (submission.titleSlug != null && submission.title != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => QuestionDetailsScreen(
                                titleSlug: submission.titleSlug!,
                                title: submission.title!,
                              ),
                            ),
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                submission.title ?? 'Unknown',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              timestamp > 0 ? _formatTimeDifference(timestamp) : '',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

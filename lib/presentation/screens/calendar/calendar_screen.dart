import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leet/core/theme/app_theme.dart';
import 'package:leet/data/models/daily_challenge_model.dart';
import 'package:leet/presentation/blocs/calendar/calendar_bloc.dart';
import 'package:leet/presentation/screens/question_details/question_details_screen.dart';
import 'package:leet/presentation/widgets/calendar/calendar_grid.dart';
import 'package:leet/presentation/widgets/calendar/problem_of_the_day_card.dart';
import 'package:leet/presentation/widgets/shimmer_widgets.dart';

class CalendarScreen extends StatefulWidget {
  final String username;
  const CalendarScreen({super.key, required this.username});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CalendarBloc>().add(LoadCalendar(username: widget.username));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgNeutral,
      appBar: AppBar(
        title: const Text('Track'),
        backgroundColor: AppTheme.bgNeutral,
        elevation: 0,
      ),
      body: BlocBuilder<CalendarBloc, CalendarState>(
        builder: (context, state) {
          if (state is CalendarLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CalendarError) {
            return Center(child: Text('Error: ${state.message}', style: const TextStyle(color: Colors.red)));
          } else if (state is CalendarLoaded) {
            
            final currentMonth = state.currentMonth ?? DateTime.now();
            final challengesList = state.dailyChallenges?.data?.dailyCodingChallengeV2?.challenges ?? [];
            
            // Convert list to map for the grid
            final Map<DateTime, DailyChallenge> challengesMap = {};
            for (var challenge in challengesList) {
              if (challenge.date != null) {
                try {
                  final date = DateTime.parse(challenge.date!);
                  final normalizedDate = DateTime(date.year, date.month, date.day);
                  challengesMap[normalizedDate] = challenge;
                } catch (e) {
                  // ignore parse error
                }
              }
            }

            // Find today's challenge
            final today = DateTime.now();
            final normalizedToday = DateTime(today.year, today.month, today.day);
            final todayChallenge = challengesMap[normalizedToday];

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   if (todayChallenge != null) ...[
                     ProblemOfTheDayCard(
                       challenge: todayChallenge,
                       date: todayChallenge.date ?? DateTime.now().toString(),
                       onTap: () => _showChallengeDetails(context, todayChallenge),
                     ),
                     const SizedBox(height: 24),
                   ],
                   
                   CalendarGrid(
                     currentMonth: currentMonth,
                     dailyChallenges: challengesMap,
                     onDateClick: (challenge) => _showChallengeDetails(context, challenge),
                     onNextMonth: () {
                       context.read<CalendarBloc>().add(NextMonth());
                     },
                     onPreviousMonth: () {
                       context.read<CalendarBloc>().add(PreviousMonth());
                     },
                   ),
                   const SizedBox(height: 24),
                   _buildCalendarGuide(),
                ],
              ),
            );
          }
          return const Center(child: Text("No data available", style: TextStyle(color: Colors.white)));
        },
      ),
    );
  }

  void _showChallengeDetails(BuildContext context, DailyChallenge challenge) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Daily Challenge',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
               Text(
                challenge.question?.title ?? 'Unknown',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getDifficultyColor(challenge.question?.difficulty).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      challenge.question?.difficulty ?? 'Unknown',
                      style: TextStyle(
                        color: _getDifficultyColor(challenge.question?.difficulty),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  if (challenge.userStatus == 'Finish')
                    const Row(
                      children: [
                        Icon(Icons.check_circle, color: AppTheme.easyColor, size: 16),
                        SizedBox(width: 4),
                        Text('Solved', style: TextStyle(color: AppTheme.easyColor)),
                      ],
                    ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    if (challenge.question?.titleSlug != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => QuestionDetailsScreen(
                            titleSlug: challenge.question!.titleSlug!,
                            title: challenge.question!.title!,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('View Problem', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getDifficultyColor(String? difficulty) {
    switch (difficulty) {
      case 'Easy': return AppTheme.easyColor;
      case 'Medium': return AppTheme.mediumColor;
      case 'Hard': return AppTheme.hardColor;
      default: return AppTheme.textSecondary;
    }
  }

  Widget _buildCalendarGuide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Calendar Guide',
          style: TextStyle(color: AppTheme.textPrimary, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildGuideItem(AppTheme.primaryBlue, "Today's date"),
        const SizedBox(height: 8),
        _buildGuideItem(AppTheme.easyColor, "Date with assigned question (click to view)"),
      ],
    );
  }

  Widget _buildGuideItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color.withOpacity(0.3),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 1), // Optional border for guide
          ),
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(color: AppTheme.textSecondary),
        ),
      ],
    );
  }
}

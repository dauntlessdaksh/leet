import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leet/core/theme/app_theme.dart';
import 'package:leet/domain/repositories/leetcode_repository.dart';
import 'package:leet/domain/usecases/fetch_user_stats_usecase.dart';
import 'package:leet/domain/usecases/fetch_calendar_usecase.dart';
import 'package:leet/domain/usecases/fetch_contest_rating_usecase.dart';
import 'package:leet/presentation/blocs/compare/compare_bloc.dart';

class CompareScreen extends StatelessWidget {
  final String username1;
  final String username2;

  const CompareScreen({
    super.key,
    required this.username1,
    required this.username2,
  });

  @override
  Widget build(BuildContext context) {
    final repo = context.read<LeetCodeRepository>();
    
    return BlocProvider(
      create: (context) => CompareBloc(
        fetchUserStatsUseCase: FetchUserStatsUseCase(repo),
        fetchContestRatingUseCase: FetchContestRatingUseCase(repo),
        fetchCalendarUseCase: FetchCalendarUseCase(repo),
      )..add(CompareUsers(username1, username2)),
      child: Scaffold(
        backgroundColor: AppTheme.bgNeutral,
        appBar: AppBar(
          title: const Text('Compare Users'),
        ),
        body: BlocBuilder<CompareBloc, CompareState>(
          builder: (context, state) {
            if (state is CompareLoading) {
               return const Center(child: CircularProgressIndicator());
            } else if (state is CompareError) {
              return Center(child: Text('Error: ${state.message}', style: const TextStyle(color: Colors.red)));
            } else if (state is CompareLoaded) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // VS Header
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            username1,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Icon(Icons.compare_arrows_rounded, color: AppTheme.primaryColor, size: 32),
                          ),
                          Text(
                            username2,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // User Cards Side by Side
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _UserStatsCard(
                            username: username1,
                            stats: state.user1Stats,
                            contest: state.user1Contest,
                            calendar: state.user1Calendar,
                            isLeft: true,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _UserStatsCard(
                            username: username2,
                            stats: state.user2Stats,
                            contest: state.user2Contest,
                            calendar: state.user2Calendar,
                            isLeft: false,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _UserStatsCard extends StatelessWidget {
  final String username;
  final dynamic stats;
  final dynamic contest;
  final dynamic calendar;
  final bool isLeft;

  const _UserStatsCard({
    required this.username,
    required this.stats,
    required this.contest,
    required this.calendar,
    required this.isLeft,
  });

  @override
  Widget build(BuildContext context) {
    int totalSolved = 0;
    int easy = 0;
    int medium = 0;
    int hard = 0;
    
    try {
      totalSolved = stats?.allQuestionsCount?.firstWhere((e) => e.difficulty == 'All').count ?? 0;
    } catch (_) {}
    
    try {
      easy = stats?.matchedUser?.submitStats?.acSubmissionNum?.firstWhere((e) => e.difficulty == 'Easy').count ?? 0;
    } catch (_) {}
    
    try {
      medium = stats?.matchedUser?.submitStats?.acSubmissionNum?.firstWhere((e) => e.difficulty == 'Medium').count ?? 0;
    } catch (_) {}
    
    try {
      hard = stats?.matchedUser?.submitStats?.acSubmissionNum?.firstWhere((e) => e.difficulty == 'Hard').count ?? 0;
    } catch (_) {}
    
    final rating = contest?.data?.userContestRanking?.rating?.toInt() ?? 0;
    final rank = contest?.data?.userContestRanking?.globalRanking ?? 0;
    final streak = calendar?.data?.matchedUser?.userCalendar?.streak ?? 0;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.cardBg,
            AppTheme.cardBg.withOpacity(0.7),
          ],
          begin: isLeft ? Alignment.topLeft : Alignment.topRight,
          end: isLeft ? Alignment.bottomRight : Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Avatar and Username
            CircleAvatar(
              radius: 35,
              backgroundColor: AppTheme.primaryColor.withOpacity(0.2),
              child: Icon(
                Icons.person_rounded,
                color: AppTheme.primaryColor,
                size: 40,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              username,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            
            const SizedBox(height: 20),
            const Divider(color: AppTheme.textSecondary, thickness: 1),
            const SizedBox(height: 12),
            
            // Total Solved
            _StatItem(
              label: 'Total Solved',
              value: totalSolved.toString(),
              icon: Icons.check_circle_rounded,
              color: AppTheme.primaryColor,
            ),
            
            const SizedBox(height: 16),
            
            // Difficulty Stats
            _StatItem(
              label: 'Easy',
              value: easy.toString(),
              icon: Icons.circle,
              color: AppTheme.easyColor,
              isSmall: true,
            ),
            const SizedBox(height: 8),
            _StatItem(
              label: 'Medium',
              value: medium.toString(),
              icon: Icons.circle,
              color: AppTheme.mediumColor,
              isSmall: true,
            ),
            const SizedBox(height: 8),
            _StatItem(
              label: 'Hard',
              value: hard.toString(),
              icon: Icons.circle,
              color: AppTheme.hardColor,
              isSmall: true,
            ),
            
            const SizedBox(height: 12),
            const Divider(color: AppTheme.textSecondary, thickness: 1),
            const SizedBox(height: 12),
            
            // Contest Stats
            _StatItem(
              label: 'Rating',
              value: rating.toString(),
              icon: Icons.emoji_events_rounded,
              color: AppTheme.primaryColor,
            ),
            const SizedBox(height: 12),
            _StatItem(
              label: 'Global Rank',
              value: rank.toString(),
              icon: Icons.leaderboard_rounded,
              color: AppTheme.primaryColor,
            ),
            
            const SizedBox(height: 12),
            const Divider(color: AppTheme.textSecondary, thickness: 1),
            const SizedBox(height: 12),
            
            // Streak
            _StatItem(
              label: 'Streak',
              value: '$streak days',
              icon: Icons.local_fire_department_rounded,
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final bool isSmall;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color, size: isSmall ? 14 : 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: isSmall ? 12 : 14,
              color: AppTheme.textSecondary,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isSmall ? 14 : 16,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }
}

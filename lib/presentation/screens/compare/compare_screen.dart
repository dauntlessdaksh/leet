import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leet/core/theme/app_theme.dart';
import 'package:leet/domain/repositories/leetcode_repository.dart';
import 'package:leet/domain/usecases/fetch_user_stats_usecase.dart';
import 'package:leet/domain/usecases/fetch_calendar_usecase.dart';
import 'package:leet/domain/usecases/fetch_contest_rating_usecase.dart';
import 'package:leet/presentation/blocs/compare/compare_bloc.dart';
import 'package:leet/presentation/widgets/shimmer_widgets.dart';

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
                    // Header with names
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildUserHeader(username1),
                        const Icon(Icons.compare_arrows, color: AppTheme.primaryColor),
                        _buildUserHeader(username2),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    // Stats Comparison (Example: Total Solved)
                    _buildComparisonRow(
                      'Total Solved',
                      state.user1Stats?.allQuestionsCount?.firstWhere((e) => e.difficulty == 'All').count ?? 0,
                      state.user2Stats?.allQuestionsCount?.firstWhere((e) => e.difficulty == 'All').count ?? 0,
                    ),
                    const Divider(color: Colors.grey),
                    _buildComparisonRow(
                      'Easy',
                      state.user1Stats?.matchedUser?.submitStats?.acSubmissionNum?.firstWhere((e) => e.difficulty == 'Easy').count ?? 0,
                      state.user2Stats?.matchedUser?.submitStats?.acSubmissionNum?.firstWhere((e) => e.difficulty == 'Easy').count ?? 0,
                      color: AppTheme.easyColor
                    ),
                     _buildComparisonRow(
                      'Medium',
                      state.user1Stats?.matchedUser?.submitStats?.acSubmissionNum?.firstWhere((e) => e.difficulty == 'Medium').count ?? 0,
                      state.user2Stats?.matchedUser?.submitStats?.acSubmissionNum?.firstWhere((e) => e.difficulty == 'Medium').count ?? 0,
                      color: AppTheme.mediumColor
                    ),
                     _buildComparisonRow(
                      'Hard',
                      state.user1Stats?.matchedUser?.submitStats?.acSubmissionNum?.firstWhere((e) => e.difficulty == 'Hard').count ?? 0,
                      state.user2Stats?.matchedUser?.submitStats?.acSubmissionNum?.firstWhere((e) => e.difficulty == 'Hard').count ?? 0,
                      color: AppTheme.hardColor
                    ),
                    
                     const Divider(color: Colors.grey),
                     _buildComparisonRow(
                       'Contest Rating', 
                       state.user1Contest?.data?.userContestRanking?.rating?.toInt() ?? 0, 
                       state.user2Contest?.data?.userContestRanking?.rating?.toInt() ?? 0,
                     ),
                     _buildComparisonRow(
                       'Global Rank', 
                       state.user1Contest?.data?.userContestRanking?.globalRanking ?? 0, 
                       state.user2Contest?.data?.userContestRanking?.globalRanking ?? 0,
                       reverse: true, // Lower is better
                     ),
                     
                     const Divider(color: Colors.grey),
                     _buildComparisonRow(
                       'Streak', 
                       state.user1Calendar?.data?.matchedUser?.userCalendar?.streak ?? 0, 
                       state.user2Calendar?.data?.matchedUser?.userCalendar?.streak ?? 0,
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

  Widget _buildUserHeader(String username) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundColor: AppTheme.cardBg,
          child: Icon(Icons.person, color: AppTheme.textPrimary),
        ),
        const SizedBox(height: 8),
        Text(
          username,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildComparisonRow(String label, int val1, int val2, {Color? color, bool reverse = false}) {
    bool win1 = reverse ? val1 < val2 : val1 > val2;
    bool win2 = reverse ? val2 < val1 : val2 > val1;
    if (val1 == val2) { win1 = false; win2 = false; }
    if (val1 == 0 && val2 == 0) { win1 = false; win2 = false; } // Handle 0 case if needed

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           Expanded(
             child: Text(
               '$val1', 
               textAlign: TextAlign.center,
               style: TextStyle(
                 fontWeight: FontWeight.bold, 
                 color: win1 ? AppTheme.primaryColor : AppTheme.textPrimary,
                 fontSize: 16,
               )
             ),
           ),
           Expanded(
             child: Text(
               label, 
               textAlign: TextAlign.center,
               style: TextStyle(color: color ?? AppTheme.textSecondary),
             ),
           ),
           Expanded(
             child: Text(
               '$val2', 
               textAlign: TextAlign.center,
               style: TextStyle(
                 fontWeight: FontWeight.bold, 
                 color: win2 ? AppTheme.primaryColor : AppTheme.textPrimary,
                 fontSize: 16,
               )
             ),
           ),
        ],
      ),
    );
  }
}

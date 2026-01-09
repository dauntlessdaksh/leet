import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leet/core/theme/app_theme.dart';
import 'package:leet/data/models/user_model.dart';
import 'package:leet/domain/repositories/leetcode_repository.dart';
import 'package:leet/domain/usecases/fetch_user_profile_usecase.dart';
import 'package:leet/domain/usecases/fetch_user_stats_usecase.dart';
import 'package:leet/domain/usecases/fetch_contest_rating_usecase.dart';
import 'package:leet/domain/usecases/fetch_recent_submissions_usecase.dart';
import 'package:leet/presentation/blocs/user_details/user_details_bloc.dart';
import 'package:leet/presentation/widgets/home_header.dart';
import 'package:leet/presentation/widgets/question_progress_widget.dart';
import 'package:leet/presentation/widgets/shimmer_widgets.dart';
import 'package:intl/intl.dart';

class UserDetailsScreen extends StatelessWidget {
  final String username;

  const UserDetailsScreen({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    final repo = context.read<LeetCodeRepository>();
    
    return BlocProvider(
      create: (context) => UserDetailsBloc(
        fetchUserProfileUseCase: FetchUserProfileUseCase(repo),
        fetchUserStatsUseCase: FetchUserStatsUseCase(repo),
        fetchContestRatingUseCase: FetchContestRatingUseCase(repo),
        fetchRecentSubmissionsUseCase: FetchRecentSubmissionsUseCase(repo),
      )..add(LoadUserDetails(username)),
      child: Scaffold(
        backgroundColor: AppTheme.bgNeutral,
        appBar: AppBar(
          title: Text(username),
        ),
        body: BlocBuilder<UserDetailsBloc, UserDetailsState>(
          builder: (context, state) {
            if (state is UserDetailsLoading) {
               return const SingleChildScrollView(
                 padding: EdgeInsets.all(16.0),
                 child: HomeScreenShimmer(),
               );
            } else if (state is UserDetailsError) {
              return Center(child: Text('Error: ${state.message}', style: const TextStyle(color: Colors.red)));
            } else if (state is UserDetailsLoaded) {
              final entries = state.recentSubmissions?.data?.recentAcSubmissionList ?? [];
              
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    HomeHeader(userInfo: state.userProfile),
                    const SizedBox(height: 20),
                    QuestionProgressCard(userStats: state.userStats),
                    const SizedBox(height: 20),
                    // Contest Stats
                    // Contest Stats
                    // Always show card to verify visibility
                      Card(
                        color: AppTheme.cardBg,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Contest Rating', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                              const SizedBox(height: 12),
                              if (state.contestRanking?.data?.userContestRanking != null) ...[
                                Text('Rating: ${state.contestRanking!.data!.userContestRanking!.rating?.toInt() ?? 0}', style: const TextStyle(color: AppTheme.textPrimary)),
                                Text('Global Ranking: ${state.contestRanking!.data!.userContestRanking!.globalRanking ?? 0}', style: const TextStyle(color: AppTheme.textSecondary)),
                              ] else ...[
                                const Text('No contest data available', style: TextStyle(color: AppTheme.textSecondary)),
                              ]
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 24),
                    // Recent Submissions - Always show header
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Recent Submissions (${entries.length})',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (entries.isNotEmpty) 
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: entries.length,
                        itemBuilder: (context, index) {
                          final sub = entries[index];
                          final timestampStr = sub.timestamp?.toString() ?? '0';
                          final date = DateTime.fromMillisecondsSinceEpoch(int.parse(timestampStr) * 1000);
                          final formattedDate = DateFormat.yMMMd().format(date);
                          
                          return Card(
                            color: AppTheme.cardBg,
                            margin: const EdgeInsets.only(bottom: 12),
                            child: ListTile(
                              title: Text(sub.title ?? 'Unknown', style: const TextStyle(color: AppTheme.textPrimary)),
                              subtitle: Text(formattedDate, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                              trailing: const Text(
                                'Accepted', 
                                style: TextStyle(
                                  color: AppTheme.easyColor,
                                  fontWeight: FontWeight.bold
                                )
                              ),
                            ),
                          );
                        },
                      )
                    else 
                       const Padding(
                         padding: EdgeInsets.symmetric(vertical: 20),
                         child: Center(
                           child: Text(
                             'No recent submissions found', 
                             style: TextStyle(color: AppTheme.textSecondary)
                           ),
                         ),
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

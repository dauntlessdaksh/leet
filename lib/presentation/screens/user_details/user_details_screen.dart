import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leet/core/theme/app_theme.dart';
import 'package:leet/data/models/user_model.dart';
import 'package:leet/domain/repositories/leetcode_repository.dart';
import 'package:leet/domain/usecases/fetch_user_profile_usecase.dart';
import 'package:leet/domain/usecases/fetch_user_stats_usecase.dart';
import 'package:leet/domain/usecases/fetch_contest_rating_usecase.dart';
import 'package:leet/presentation/blocs/user_details/user_details_bloc.dart';
import 'package:leet/presentation/widgets/home_header.dart';
import 'package:leet/presentation/widgets/question_progress_widget.dart';
import 'package:leet/presentation/widgets/shimmer_widgets.dart';

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
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    HomeHeader(userInfo: state.userProfile),
                    const SizedBox(height: 20),
                    QuestionProgressCard(userStats: state.userStats),
                    const SizedBox(height: 20),
                    // Could add contest stats here
                     if (state.contestRanking?.data?.userContestRanking != null)
                      Card(
                        color: AppTheme.cardBg,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Contest Rating', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                              const SizedBox(height: 12),
                              Text('Rating: ${state.contestRanking!.data!.userContestRanking!.rating?.toInt() ?? 0}', style: const TextStyle(color: AppTheme.textPrimary)),
                              Text('Global Ranking: ${state.contestRanking!.data!.userContestRanking!.globalRanking ?? 0}', style: const TextStyle(color: AppTheme.textSecondary)),
                            ],
                          ),
                        ),
                      )
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

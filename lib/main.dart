import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leet/app/app.dart';
import 'package:leet/core/network/dio_client.dart';
import 'package:leet/data/datasources/remote/leetcode_remote_datasource.dart';
import 'package:leet/data/repositories/leetcode_repository_impl.dart';
import 'package:leet/domain/repositories/leetcode_repository.dart';
import 'package:leet/domain/usecases/fetch_user_profile_usecase.dart';
import 'package:leet/domain/usecases/fetch_user_stats_usecase.dart';
import 'package:leet/domain/usecases/fetch_calendar_usecase.dart';
import 'package:leet/domain/usecases/fetch_contest_rating_usecase.dart';
import 'package:leet/domain/usecases/fetch_badges_usecase.dart';
import 'package:leet/domain/usecases/fetch_recent_submissions_usecase.dart';
import 'package:leet/domain/usecases/fetch_daily_challenge_usecase.dart';
import 'package:leet/domain/usecases/fetch_questions_usecase.dart';
import 'package:leet/domain/usecases/search_questions_usecase.dart';

import 'package:leet/presentation/blocs/auth/auth_bloc.dart';
import 'package:leet/presentation/blocs/home/home_bloc.dart';
import 'package:leet/presentation/blocs/questions/questions_bloc.dart';
import 'package:leet/presentation/blocs/settings/settings_bloc.dart';
import 'package:leet/presentation/blocs/calendar/calendar_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final dioClient = DioClient();
  final remoteDataSource = LeetCodeRemoteDataSource(dioClient);
  final repository = LeetCodeRepositoryImpl(remoteDataSource);

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LeetCodeRepository>.value(value: repository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              FetchUserProfileUseCase(context.read<LeetCodeRepository>()),
            )..add(CheckAuthStatus()),
          ),
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(
              fetchUserProfileUseCase: FetchUserProfileUseCase(context.read<LeetCodeRepository>()),
              fetchUserStatsUseCase: FetchUserStatsUseCase(context.read<LeetCodeRepository>()),
              fetchCalendarUseCase: FetchCalendarUseCase(context.read<LeetCodeRepository>()),
              fetchContestRatingUseCase: FetchContestRatingUseCase(context.read<LeetCodeRepository>()),
              fetchBadgesUseCase: FetchBadgesUseCase(context.read<LeetCodeRepository>()),
              fetchRecentSubmissionsUseCase: FetchRecentSubmissionsUseCase(context.read<LeetCodeRepository>()),
            ),
          ),
          BlocProvider<QuestionsBloc>(
            create: (context) => QuestionsBloc(
              fetchQuestionsUseCase: FetchQuestionsUseCase(context.read<LeetCodeRepository>()),
              searchQuestionsUseCase: SearchQuestionsUseCase(context.read<LeetCodeRepository>()),
            ),
          ),
          BlocProvider<CalendarBloc>(
            create: (context) => CalendarBloc(
              fetchCalendarUseCase: FetchCalendarUseCase(context.read<LeetCodeRepository>()),
              fetchDailyChallengeUseCase: FetchDailyChallengeUseCase(context.read<LeetCodeRepository>()),
            ),
          ),
          BlocProvider<SettingsBloc>(
            create: (context) => SettingsBloc(),
          ),
        ],
        child: const LeetApp(),
      ),
    ),
  );
}

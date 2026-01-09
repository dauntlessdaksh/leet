import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leet/core/theme/app_theme.dart';
import 'package:leet/presentation/blocs/home/home_bloc.dart';
import 'package:leet/presentation/widgets/shimmer_widgets.dart';
import 'package:leet/presentation/widgets/home_header.dart';
import 'package:leet/presentation/widgets/question_progress_widget.dart';
import 'package:leet/presentation/widgets/calendar_heatmap_card.dart';
import 'package:leet/presentation/blocs/auth/auth_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      context.read<HomeBloc>().add(LoadHomeData(authState.username));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgNeutral,
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(LogoutRequested());
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final authState = context.read<AuthBloc>().state;
          if (authState is AuthAuthenticated) {
            context.read<HomeBloc>().add(RefreshHomeData(authState.username));
            // Wait for state change or simple delay?
            // Ideally RefreshIndicator waits for future.
            // Since bloc is void/event based, we can't await easily.
            // Using logic in bloc to fetch is async.
            // For UI/UX simplifying:
            await Future.delayed(const Duration(seconds: 1)); 
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeInitial || state is HomeLoading) {
               return const HomeScreenShimmer();
            } else if (state is HomeError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Error: ${state.message}", style: const TextStyle(color: Colors.red)),
                    ElevatedButton(onPressed: _loadData, child: const Text("Retry")),
                  ],
                ),
              );
            } else if (state is HomeLoaded) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    HomeHeader(userInfo: state.userStats?.matchedUser),
                    const SizedBox(height: 20),
                    QuestionProgressCard(userStats: state.userStats),
                    const SizedBox(height: 20),
                    if (state.calendar?.data?.matchedUser?.userCalendar != null)
                      CalendarHeatmapCard(
                        submissionCalendar: state.calendar!.data!.matchedUser!.userCalendar!.submissionCalendar,
                        activeYears: state.calendar!.data!.matchedUser!.userCalendar!.activeYears?.length ?? 0,
                        totalActiveDays: state.calendar!.data!.matchedUser!.userCalendar!.totalActiveDays ?? 0,
                        streak: state.calendar!.data!.matchedUser!.userCalendar!.streak ?? 0,
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

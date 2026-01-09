import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leet/core/theme/app_theme.dart';
import 'package:leet/presentation/blocs/calendar/calendar_bloc.dart';
import 'package:leet/presentation/widgets/calendar_heatmap_card.dart';
import 'package:leet/presentation/widgets/shimmer_widgets.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Note: CalendarBloc is provided typically at screen level, but we need
    // to know which user. Assuming this is for current user (Tab).
    // Or we provide the bloc from parent.
    // If it's a tab, we likely want to use the same logic as Home or specialized.
    // Here we'll rely on the existing bloc if available or simply show placeholder
    // as Home captures Heatmap. The Android app has "Activity" tab which is basically
    // Heatmap + Daily Challenges.
    
    // For this implementation, I'll display the heatmap again + Daily challenges list from Bloc.
    
    return Scaffold(
      backgroundColor: AppTheme.bgNeutral,
      appBar: AppBar(title: const Text('Activity')),
      body: BlocBuilder<CalendarBloc, CalendarState>(
        builder: (context, state) {
           if (state is CalendarLoading) {
             return const Padding(padding: EdgeInsets.all(16), child: ShimmerWidget.rectangular(height: 300));
           } else if (state is CalendarError) {
             return Center(child: Text('Error: ${state.message}'));
           } else if (state is CalendarLoaded) {
             final challenges = state.dailyChallenges?.data?.dailyCodingChallengeV2?.challenges ?? [];
             
             return SingleChildScrollView(
               padding: const EdgeInsets.all(16.0),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    if (state.calendar?.data?.matchedUser?.userCalendar != null)
                      CalendarHeatmapCard(
                        submissionCalendar: state.calendar!.data!.matchedUser!.userCalendar!.submissionCalendar,
                        activeYears: state.calendar!.data!.matchedUser!.userCalendar!.activeYears?.length ?? 0,
                        totalActiveDays: state.calendar!.data!.matchedUser!.userCalendar!.totalActiveDays ?? 0,
                        streak: state.calendar!.data!.matchedUser!.userCalendar!.streak ?? 0,
                      ),
                    const SizedBox(height: 24),
                    const Text('Daily Challenges', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
                    const SizedBox(height: 12),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: challenges.length,
                      itemBuilder: (context, index) {
                        final challenge = challenges[index];
                        return ListTile(
                          title: Text(challenge.question?.title ?? '', style: const TextStyle(color: AppTheme.textPrimary)),
                          subtitle: Text(challenge.date ?? '', style: const TextStyle(color: AppTheme.textSecondary)),
                          leading: Icon(
                            challenge.userStatus == 'Finish' ? Icons.check_circle : Icons.circle_outlined,
                            color: challenge.userStatus == 'Finish' ? AppTheme.easyColor : Colors.grey,
                          ),
                        );
                      },
                    )
                 ],
               ),
             );
           }
           return const Center(child: Text("Select a user to view activity", style: TextStyle(color: Colors.white)));
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leet/core/theme/app_theme.dart';
import 'package:leet/presentation/blocs/contests/contests_bloc.dart';
import 'package:leet/data/models/contest_list_model.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ContestsScreen extends StatelessWidget {
  const ContestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppTheme.bgNeutral,
        appBar: AppBar(
          title: const Text('Contests'),
          bottom: const TabBar(
            indicatorColor: AppTheme.primaryColor,
            labelColor: AppTheme.primaryColor,
            unselectedLabelColor: AppTheme.textSecondary,
            tabs: [
              Tab(text: 'All Contests'),
              Tab(text: 'Upcoming'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _AllContestsTab(),
            _UpcomingContestsTab(),
          ],
        ),
      ),
    );
  }
}

class _AllContestsTab extends StatefulWidget {
  @override
  State<_AllContestsTab> createState() => _AllContestsTabState();
}

class _AllContestsTabState extends State<_AllContestsTab> {
  @override
  void initState() {
    super.initState();
    context.read<ContestsBloc>().add(LoadAllContests());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContestsBloc, ContestsState>(
      builder: (context, state) {
        if (state is ContestsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AllContestsLoaded) {
          if (state.contests.isEmpty) {
            return const Center(
              child: Text('No contests found',
                  style: TextStyle(color: AppTheme.textSecondary)),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.contests.length,
            itemBuilder: (context, index) {
              return _ContestCard(contest: state.contests[index]);
            },
          );
        } else if (state is ContestsError) {
          final is429Error = state.message.contains('429');
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    is429Error ? Icons.hourglass_empty : Icons.error_outline,
                    size: 64,
                    color: is429Error ? AppTheme.primaryColor : Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    is429Error
                        ? 'Rate Limit Reached'
                        : 'Error Loading Contests',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    is429Error
                        ? 'LeetCode API has rate limiting. Please wait a moment before trying again.'
                        : state.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<ContestsBloc>().add(LoadAllContests());
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _UpcomingContestsTab extends StatefulWidget {
  @override
  State<_UpcomingContestsTab> createState() => _UpcomingContestsTabState();
}

class _UpcomingContestsTabState extends State<_UpcomingContestsTab> {
  @override
  void initState() {
    super.initState();
    context.read<ContestsBloc>().add(LoadUpcomingContests());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContestsBloc, ContestsState>(
      builder: (context, state) {
        if (state is ContestsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UpcomingContestsLoaded) {
          if (state.contests.isEmpty) {
            return const Center(
              child: Text('No upcoming contests',
                  style: TextStyle(color: AppTheme.textSecondary)),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.contests.length,
            itemBuilder: (context, index) {
              return _ContestCard(contest: state.contests[index]);
            },
          );
        } else if (state is ContestsError) {
          final is429Error = state.message.contains('429');
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    is429Error ? Icons.hourglass_empty : Icons.error_outline,
                    size: 64,
                    color: is429Error ? AppTheme.primaryColor : Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    is429Error
                        ? 'Rate Limit Reached'
                        : 'Error Loading Contests',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    is429Error
                        ? 'LeetCode API has rate limiting. Please wait a moment before trying again.'
                        : state.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<ContestsBloc>().add(LoadUpcomingContests());
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _ContestCard extends StatelessWidget {
  final ContestItem contest;

  const _ContestCard({required this.contest});

  String _formatDate(int? timestamp) {
    if (timestamp == null) return 'TBA';
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('MMM dd, yyyy - HH:mm').format(date);
  }

  String _formatDuration(int? seconds) {
    if (seconds == null) return 'TBA';
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    return '${hours}h ${minutes}m';
  }

  @override
  Widget build(BuildContext context) {
    // Determine if contest is active or upcoming for styling tweaks if needed
    // For now, consistent 3D card style
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.cardBg,
            AppTheme.cardBg.withOpacity(0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.15),
          width: 1.5,
        ),
        boxShadow: [
          // Dark shadow for depth
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(5, 5),
          ),
          // Light glow/highlight for 3D effect
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(-2, -2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showContestDialog(context),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.emoji_events_rounded,
                        color: AppTheme.primaryColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        contest.title ?? 'Unknown Contest',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                    if (contest.containsPremium == true)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.orange.shade700, Colors.orange.shade500],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.4),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Text(
                          'PREMIUM',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                
                // Info Grid
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoItem(
                        Icons.calendar_month_rounded, 
                        'Start Time', 
                        _formatDate(contest.startTime),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 1,
                      color: AppTheme.textSecondary.withOpacity(0.2),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: _buildInfoItem(
                          Icons.timer_rounded, 
                          'Duration', 
                          _formatDuration(contest.duration),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: AppTheme.textSecondary),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: AppTheme.textSecondary.withOpacity(0.8),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  void _showContestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardBg,
        title: Text(
          contest.title ?? 'Contest Details',
          style: const TextStyle(color: AppTheme.textPrimary),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Start Time', _formatDate(contest.startTime)),
            const SizedBox(height: 8),
            _buildDetailRow('Duration', _formatDuration(contest.duration)),
            const SizedBox(height: 8),
            _buildDetailRow(
                'Virtual', contest.isVirtual == true ? 'Yes' : 'No'),
            if (contest.containsPremium == true) ...[
              const SizedBox(height: 8),
              _buildDetailRow('Premium', 'Yes'),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton.icon(
            onPressed: () => _openContestOnLeetCode(),
            icon: const Icon(Icons.open_in_new),
            label: const Text('View on LeetCode'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            '$label:',
            style: const TextStyle(
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: AppTheme.textPrimary),
          ),
        ),
      ],
    );
  }

  Future<void> _openContestOnLeetCode() async {
    if (contest.titleSlug == null) return;

    final url = Uri.parse('https://leetcode.com/contest/${contest.titleSlug}/');

    try {
      final canLaunch = await canLaunchUrl(url);
      if (canLaunch) {
        await launchUrl(url, mode: LaunchMode.platformDefault);
      } else {
        // Fallback: try to launch anyway
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      // Show error to user
      print('Error opening URL: $e');
    }
  }
}

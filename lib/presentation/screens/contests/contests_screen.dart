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
          return Center(
            child: Text('Error: ${state.message}',
                style: const TextStyle(color: Colors.red)),
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
          return Center(
            child: Text('Error: ${state.message}',
                style: const TextStyle(color: Colors.red)),
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
    return Card(
      color: AppTheme.cardBg,
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _showContestDialog(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                contest.title ?? 'Unknown Contest',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.calendar_today,
                      size: 16, color: AppTheme.textSecondary),
                  const SizedBox(width: 8),
                  Text(
                    _formatDate(contest.startTime),
                    style: const TextStyle(color: AppTheme.textSecondary),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.access_time,
                      size: 16, color: AppTheme.textSecondary),
                  const SizedBox(width: 8),
                  Text(
                    _formatDuration(contest.duration),
                    style: const TextStyle(color: AppTheme.textSecondary),
                  ),
                ],
              ),
              if (contest.containsPremium == true)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Premium',
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leet/core/theme/app_theme.dart';
import 'package:leet/presentation/blocs/questions/questions_bloc.dart';
import 'package:leet/presentation/widgets/question_list_tile.dart';
import 'package:leet/presentation/widgets/shimmer_widgets.dart';
import 'package:leet/presentation/widgets/questions_filter_modal.dart';
import 'package:leet/presentation/screens/question_details/question_details_screen.dart';
import 'package:leet/data/models/question_model.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  
  String? _selectedDifficulty;
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
    _scrollController.addListener(_onScroll);
  }

  void _loadQuestions() {
    context.read<QuestionsBloc>().add(LoadQuestions());
  }

  void _onScroll() {
    if (_isBottom) {
      final state = context.read<QuestionsBloc>().state;
      if (state is QuestionsLoaded && state.hasMore) {
        context.read<QuestionsBloc>().add(LoadQuestions(
          offset: state.questions.length,
          difficulty: _selectedDifficulty,
          status: _selectedStatus,
          searchQuery: _searchController.text,
        ));
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }
  
  void _openFilter() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => QuestionsFilterModal(
        selectedDifficulty: _selectedDifficulty,
        selectedStatus: _selectedStatus,
        onApply: (diff, stat) {
          setState(() {
            _selectedDifficulty = diff;
            _selectedStatus = stat;
          });
          context.read<QuestionsBloc>().add(LoadQuestions(
            difficulty: _selectedDifficulty,
            status: _selectedStatus,
            searchQuery: _searchController.text,
          ));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgNeutral,
      appBar: AppBar(
        title: const Text('Problems'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _openFilter,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search questions...',
                prefixIcon: Icon(Icons.search),
              ),
              onSubmitted: (value) {
                // If value is empty, reload normal list
                if (value.isEmpty) {
                   context.read<QuestionsBloc>().add(LoadQuestions(
                     difficulty: _selectedDifficulty,
                     status: _selectedStatus,
                   ));
                } else {
                   context.read<QuestionsBloc>().add(SearchQuestions(value));
                }
              },
            ),
          ),
          
          Expanded(
            child: BlocBuilder<QuestionsBloc, QuestionsState>(
              builder: (context, state) {
                if (state is QuestionsLoading && state.props.isEmpty) { // Initial loading? Not exactly, props check is flawed if not careful
                   // Better check type
                   // If Loading and no previous data, show shimmer
                   return ListView.builder(
                     padding: const EdgeInsets.all(16.0),
                     itemCount: 10,
                     itemBuilder: (_, __) => const Padding(
                       padding: EdgeInsets.only(bottom: 16.0),
                       child: ShimmerWidget.rectangular(height: 80),
                     ),
                   );
                } else if (state is QuestionsError) {
                  return Center(
                    child: Text('Error: ${state.message}', style: const TextStyle(color: Colors.red)),
                  );
                } else if (state is QuestionsLoaded) {
                  if (state.questions.isEmpty) {
                    return const Center(child: Text('No questions found', style: TextStyle(color: AppTheme.textSecondary)));
                  }
                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: state.questions.length + (state.hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == state.questions.length) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      final question = state.questions[index];
                      return QuestionListTile(
                        question: question, 
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => QuestionDetailsScreen(
                                titleSlug: question.titleSlug, 
                                title: question.title
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else if (state is SearchQuestionsLoaded) {
                   // Adapt SearchQuestionNode to Question or create separate tile
                   // Or mapping
                   final questions = state.questions;
                   if (questions.isEmpty) {
                      return const Center(child: Text('No questions found', style: TextStyle(color: AppTheme.textSecondary)));
                   }
                   return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: questions.length,
                      itemBuilder: (context, index) {
                        final q = questions[index];
                        // Need adapter or similar tile. 
                        // For simplicity creating a similar tile inline or refactoring QuestionListTile to accept a common interface?
                        // Or just mapping SearchQuestionNode to Question (partial)
                        // Mapping is easier
                        // Actually I can't easily map because SearchQuestionNode has 'difficulty' as String and Question as String too. 
                        // Let's create a temporary Question object
                        final question = import_Question(
                           title: q.title,
                           titleSlug: q.titleSlug,
                           difficulty: q.difficulty,
                           acRate: q.acRate,
                           frontendQuestionId: q.questionFrontendId,
                           topicTags: [], // Search node tags are different, ignore for now or map
                           paidOnly: q.paidOnly,
                           status: q.status,
                        );
                        
                        return QuestionListTile(
                          question: question,
                          onTap: () {
                             Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => QuestionDetailsScreen(
                                    titleSlug: q.titleSlug, 
                                    title: q.title
                                  ),
                                ),
                              );
                          },
                        );
                      }
                   );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
  
  // Helper to standardise Import
}

// Helper specific to this file to avoid complex imports or modifying model
Question import_Question({
  required String title,
  required String titleSlug,
  required String difficulty,
  required double acRate,
  required String frontendQuestionId,
  required List<TopicTag> topicTags,
  required bool paidOnly,
  String? status
}) {
  return Question(
    title: title,
    titleSlug: titleSlug,
    difficulty: difficulty,
    acRate: acRate,
    frontendQuestionId: frontendQuestionId,
    topicTags: topicTags,
    paidOnly: paidOnly,
    status: status,
  );
}

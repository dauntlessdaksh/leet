import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leet/core/theme/app_theme.dart';
import 'package:leet/presentation/blocs/questions/questions_bloc.dart';
import 'package:leet/presentation/widgets/question_list_tile.dart';
import 'package:leet/presentation/widgets/shimmer_widgets.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgNeutral,
      appBar: AppBar(
        title: const Text('Problems'),
      ),
      body: Column(
        children: [
          // Search Bar - Numbers only
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                hintText: 'Search by question number...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                // Trigger search on every keystroke
                setState(() {});
              },
            ),
          ),
          
          Expanded(
            child: BlocBuilder<QuestionsBloc, QuestionsState>(
              builder: (context, state) {
                if (state is QuestionsLoading && state.props.isEmpty) {
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
                  // Client-side search filtering by question number only
                  final searchQuery = _searchController.text.trim();
                  final filteredQuestions = searchQuery.isEmpty
                      ? state.questions
                      : state.questions.where((q) {
                          return q.frontendQuestionId?.contains(searchQuery) ?? false;
                        }).toList();
                  
                  if (filteredQuestions.isEmpty) {
                    return const Center(
                      child: Text(
                        'No questions found',
                        style: TextStyle(color: AppTheme.textSecondary),
                      ),
                    );
                  }
                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: filteredQuestions.length + (state.hasMore && searchQuery.isEmpty ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == filteredQuestions.length) {
                        return const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      final question = filteredQuestions[index];
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
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

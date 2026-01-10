import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:leet/core/theme/app_theme.dart';
import 'package:leet/presentation/blocs/question_details/question_details_bloc.dart';
import 'package:leet/presentation/widgets/shimmer_widgets.dart';
import 'package:leet/presentation/widgets/floating_ai_assistant.dart';
import 'package:leet/domain/repositories/leetcode_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class QuestionDetailsScreen extends StatelessWidget {
  final String titleSlug;
  final String title;

  const QuestionDetailsScreen({
    super.key,
    required this.titleSlug,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuestionDetailsBloc(context.read<LeetCodeRepository>())
        ..add(LoadQuestionDetails(titleSlug)),
      child: Scaffold(
        backgroundColor: AppTheme.bgNeutral,
        appBar: AppBar(
          title: Text(title),
        ),
        body: Stack(
          children: [
            BlocBuilder<QuestionDetailsBloc, QuestionDetailsState>(
              builder: (context, state) {
                if (state is QuestionDetailsLoading) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                         ShimmerWidget.rectangular(height: 20),
                         SizedBox(height: 10),
                         ShimmerWidget.rectangular(height: 200),
                      ],
                    ),
                  );
                } else if (state is QuestionDetailsError) {
                  return Center(child: Text('Error: ${state.message}', style: const TextStyle(color: Colors.red)));
                } else if (state is QuestionDetailsLoaded) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Html(
                      data: state.content,
                      style: {
                        "body": Style(
                          color: AppTheme.textPrimary,
                          fontSize: FontSize(16.0),
                        ),
                        "code": Style(
                          backgroundColor: Colors.grey[800],
                          padding: HtmlPaddings.all(4),
                          fontFamily: 'monospace',
                        ),
                        "pre": Style(
                           backgroundColor: Colors.grey[800],
                           padding: HtmlPaddings.all(8),
                           color: Colors.white,
                        ),
                      },
                      onLinkTap: (url, _, __) {
                        if (url != null) {
                          launchUrl(Uri.parse(url));
                        }
                      },
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
            // Floating AI Assistant Bubble
            BlocBuilder<QuestionDetailsBloc, QuestionDetailsState>(
              builder: (context, state) {
                if (state is QuestionDetailsLoaded) {
                  return FloatingAiAssistant(
                    questionTitle: title,
                    questionContent: state.content,
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}

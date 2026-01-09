import 'package:leet/data/models/question_model.dart';
import 'package:leet/domain/repositories/leetcode_repository.dart';

class FetchQuestionsUseCase {
  final LeetCodeRepository _repository;

  FetchQuestionsUseCase(this._repository);

  Future<QuestionsResponse> call({
    String? categorySlug,
    int limit = 50,
    int skip = 0,
    String? query,
    String? difficulty,
    String? status,
    List<String>? tags,
  }) {
    return _repository.fetchQuestions(
      categorySlug: categorySlug,
      limit: limit,
      skip: skip,
      query: query,
      difficulty: difficulty,
      status: status,
      tags: tags,
    );
  }
}

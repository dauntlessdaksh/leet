import 'package:leet/data/models/question_model.dart';
import 'package:leet/domain/repositories/leetcode_repository.dart';

class SearchQuestionsUseCase {
  final LeetCodeRepository _repository;

  SearchQuestionsUseCase(this._repository);

  Future<SearchQuestionsResponse> call({
    required String keyword,
    int limit = 50,
  }) {
    return _repository.searchQuestions(keyword: keyword, limit: limit);
  }
}

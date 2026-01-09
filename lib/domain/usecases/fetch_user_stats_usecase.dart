import 'package:leet/data/models/user_stats_model.dart';
import 'package:leet/domain/repositories/leetcode_repository.dart';

class FetchUserStatsUseCase {
  final LeetCodeRepository _repository;

  FetchUserStatsUseCase(this._repository);

  Future<UserQuestionStatusData?> call(String username) {
    return _repository.fetchUserRankingInfo(username);
  }
}

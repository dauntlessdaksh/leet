import 'package:leet/data/models/contest_model.dart';
import 'package:leet/domain/repositories/leetcode_repository.dart';

class FetchContestRatingUseCase {
  final LeetCodeRepository _repository;

  FetchContestRatingUseCase(this._repository);

  Future<UserContestRankingResponse> getUserRanking(String username) {
    return _repository.fetchUserContestRanking(username);
  }

  Future<ContestRatingHistogramResponse> getHistogram() {
    return _repository.fetchContestRatingHistogram();
  }
}

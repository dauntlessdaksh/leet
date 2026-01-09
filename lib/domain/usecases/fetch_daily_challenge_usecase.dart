import 'package:leet/data/models/daily_challenge_model.dart';
import 'package:leet/domain/repositories/leetcode_repository.dart';

class FetchDailyChallengeUseCase {
  final LeetCodeRepository _repository;

  FetchDailyChallengeUseCase(this._repository);

  Future<DailyCodingChallengeResponse> call(int year, int month) {
    return _repository.fetchDailyCodingChallenge(year, month);
  }
}

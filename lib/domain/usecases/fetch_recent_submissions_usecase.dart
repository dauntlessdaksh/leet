import 'package:leet/data/models/submission_model.dart';
import 'package:leet/domain/repositories/leetcode_repository.dart';

class FetchRecentSubmissionsUseCase {
  final LeetCodeRepository _repository;

  FetchRecentSubmissionsUseCase(this._repository);

  Future<UserRecentAcSubmissionResponse> call(String username, {int limit = 15}) {
    return _repository.fetchUserRecentAcSubmissions(username, limit: limit);
  }
}

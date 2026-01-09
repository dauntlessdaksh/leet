import 'package:leet/data/models/badges_model.dart';
import 'package:leet/domain/repositories/leetcode_repository.dart';

class FetchBadgesUseCase {
  final LeetCodeRepository _repository;

  FetchBadgesUseCase(this._repository);

  Future<UserBadgesResponse> call(String username) {
    return _repository.fetchUserBadges(username);
  }
}

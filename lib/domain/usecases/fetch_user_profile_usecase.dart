import 'package:leet/data/models/user_model.dart';
import 'package:leet/domain/repositories/leetcode_repository.dart';

class FetchUserProfileUseCase {
  final LeetCodeRepository _repository;

  FetchUserProfileUseCase(this._repository);

  Future<LeetCodeUserInfo?> call(String username) {
    return _repository.fetchUserInfo(username);
  }
}

import 'package:leet/data/models/contest_list_model.dart';
import 'package:leet/domain/repositories/leetcode_repository.dart';

class FetchAllContestsUseCase {
  final LeetCodeRepository _repository;

  FetchAllContestsUseCase(this._repository);

  Future<AllContestsResponse> call() {
    return _repository.fetchAllContests();
  }
}

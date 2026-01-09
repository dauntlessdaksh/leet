import 'package:leet/data/models/contest_list_model.dart';
import 'package:leet/domain/repositories/leetcode_repository.dart';

class FetchUpcomingContestsUseCase {
  final LeetCodeRepository _repository;

  FetchUpcomingContestsUseCase(this._repository);

  Future<UpcomingContestsResponse> call() {
    return _repository.fetchUpcomingContests();
  }
}

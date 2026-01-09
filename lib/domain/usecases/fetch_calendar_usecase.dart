import 'package:leet/data/models/calendar_model.dart';
import 'package:leet/domain/repositories/leetcode_repository.dart';

class FetchCalendarUseCase {
  final LeetCodeRepository _repository;

  FetchCalendarUseCase(this._repository);

  Future<UserProfileCalendarResponse> call(String username, [int? year]) {
    return _repository.fetchUserProfileCalendar(username, year);
  }
}

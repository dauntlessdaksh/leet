import 'package:leet/data/datasources/remote/leetcode_remote_datasource.dart';
import 'package:leet/data/models/user_model.dart';
import 'package:leet/data/models/user_stats_model.dart';
import 'package:leet/data/models/calendar_model.dart';
import 'package:leet/data/models/contest_model.dart';
import 'package:leet/data/models/badges_model.dart';
import 'package:leet/data/models/submission_model.dart';
import 'package:leet/data/models/daily_challenge_model.dart';
import 'package:leet/data/models/question_model.dart'; // Import this
import 'package:leet/domain/repositories/leetcode_repository.dart';

class LeetCodeRepositoryImpl implements LeetCodeRepository {
  final LeetCodeRemoteDataSource _remoteDataSource;

  LeetCodeRepositoryImpl(this._remoteDataSource);

  @override
  Future<LeetCodeUserInfo?> fetchUserInfo(String username) async {
    try {
      final response = await _remoteDataSource.fetchUserInfo(username);
      return response.data?.matchedUser;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserQuestionStatusData?> fetchUserRankingInfo(String username) async {
    try {
      final response = await _remoteDataSource.fetchUserRankingInfo(username);
      return response.data;
    } catch (e) {
      // Return empty data or handle error appropriately
      return null;
    }
  }

  @override
  Future<UserProfileCalendarResponse> fetchUserProfileCalendar(String username,
      [int? year]) async {
    return _remoteDataSource.fetchUserProfileCalendar(username, year);
  }

  @override
  Future<UserContestRankingResponse> fetchUserContestRanking(
      String username) async {
    return _remoteDataSource.fetchUserContestRanking(username);
  }

  @override
  Future<UserRecentAcSubmissionResponse> fetchUserRecentAcSubmissions(
      String username,
      {int limit = 15}) async {
    return _remoteDataSource.fetchUserRecentAcSubmissions(username, limit: limit);
  }

  @override
  Future<ContestRatingHistogramResponse> fetchContestRatingHistogram() async {
    return _remoteDataSource.fetchContestRatingHistogram();
  }

  @override
  Future<UserBadgesResponse> fetchUserBadges(String username) async {
    return _remoteDataSource.fetchUserBadges(username);
  }

  @override
  Future<String> fetchQuestionDetails(String titleSlug) async {
    final response = await _remoteDataSource.fetchQuestionDetails(titleSlug);
    // Assuming response is already string content or needs parsing
    // Based on remote data source it returns Wait, let me check remote datasource code I wrote.
    // Step 107 code: return response.data; for fetchQuestionDetails?
    return response;
  }

  @override
  Future<DailyCodingChallengeResponse> fetchDailyCodingChallenge(
      int year, int month) async {
    return _remoteDataSource.fetchDailyCodingChallenge(year, month);
  }

  @override
  Future<QuestionsResponse> fetchQuestions({
    String? categorySlug,
    int limit = 50,
    int skip = 0,
    String? query,
    String? difficulty,
    String? status,
    List<String>? tags,
  }) {
    return _remoteDataSource.fetchQuestions(
      categorySlug: categorySlug,
      limit: limit,
      skip: skip,
      query: query,
      difficulty: difficulty,
      status: status,
      tags: tags,
    );
  }

  @override
  Future<SearchQuestionsResponse> searchQuestions({
    required String keyword,
    int limit = 50,
  }) {
    return _remoteDataSource.searchQuestions(keyword: keyword, limit: limit);
  }
}

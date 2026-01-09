import 'package:leet/data/models/user_model.dart';
import 'package:leet/data/models/user_stats_model.dart';
import 'package:leet/data/models/calendar_model.dart';
import 'package:leet/data/models/contest_model.dart';
import 'package:leet/data/models/badges_model.dart';
import 'package:leet/data/models/submission_model.dart';
import 'package:leet/data/models/daily_challenge_model.dart';
import 'package:leet/data/models/question_model.dart';

abstract class LeetCodeRepository {
  Future<LeetCodeUserInfo?> fetchUserInfo(String username);
  Future<UserQuestionStatusData?> fetchUserRankingInfo(String username);
  Future<UserProfileCalendarResponse> fetchUserProfileCalendar(String username, [int? year]);
  Future<UserContestRankingResponse> fetchUserContestRanking(String username);
  Future<UserRecentAcSubmissionResponse> fetchUserRecentAcSubmissions(String username, {int limit = 15});
  Future<ContestRatingHistogramResponse> fetchContestRatingHistogram();
  Future<UserBadgesResponse> fetchUserBadges(String username);
  Future<DailyCodingChallengeResponse> fetchDailyCodingChallenge(int year, int month);
  
  Future<QuestionsResponse> fetchQuestions({
    String? categorySlug,
    int limit,
    int skip,
    String? query,
    String? difficulty,
    String? status,
    List<String>? tags,
  });

  Future<SearchQuestionsResponse> searchQuestions({
    required String keyword,
    int limit,
  });
  
  Future<String> fetchQuestionDetails(String titleSlug);
}

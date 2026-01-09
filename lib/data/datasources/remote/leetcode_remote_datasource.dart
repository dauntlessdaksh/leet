import 'package:leet/core/network/dio_client.dart';
import 'package:leet/core/network/graphql_queries.dart';
import 'package:leet/data/models/user_model.dart';
import 'package:leet/data/models/user_stats_model.dart';
import 'package:leet/data/models/calendar_model.dart';
import 'package:leet/data/models/contest_model.dart';
import 'package:leet/data/models/badges_model.dart';
import 'package:leet/data/models/submission_model.dart';
import 'package:leet/data/models/daily_challenge_model.dart';
import 'package:leet/data/models/question_model.dart';
import 'package:leet/core/utils/constants.dart';

class LeetCodeRemoteDataSource {
  final DioClient _dioClient;

  LeetCodeRemoteDataSource(this._dioClient);

  Future<UserInfoResponse> fetchUserInfo(String username) async {
    final response = await _dioClient.post(
      AppConstants.graphqlEndpoint,
      data: {
        'query': GraphqlQueries.userExistsQuery,
        'variables': {'username': username},
        'operationName': 'userInfo',
      },
    );
    return UserInfoResponse.fromJson(response.data);
  }

  Future<UserQuestionStatusResponse> fetchUserRankingInfo(String username) async {
    final response = await _dioClient.post(
      AppConstants.graphqlEndpoint,
      data: {
        'query': GraphqlQueries.userQuestionCountQuery,
        'variables': {'username': username},
        'operationName': 'userSessionProgress',
      },
    );
    return UserQuestionStatusResponse.fromJson(response.data);
  }

  Future<UserProfileCalendarResponse> fetchUserProfileCalendar(String username, [int? year]) async {
    final response = await _dioClient.post(
      AppConstants.graphqlEndpoint,
      data: {
        'query': GraphqlQueries.userProfileCalendarQuery,
        'variables': {'username': username, 'year': year},
        'operationName': 'userProfileCalendar',
      },
    );
    return UserProfileCalendarResponse.fromJson(response.data);
  }

  Future<UserContestRankingResponse> fetchUserContestRanking(String username) async {
    final response = await _dioClient.post(
      AppConstants.graphqlEndpoint,
      data: {
        'query': GraphqlQueries.userContestRankingQuery,
        'variables': {'username': username},
        'operationName': 'userContestRankingInfo',
      },
    );
    return UserContestRankingResponse.fromJson(response.data);
  }

  Future<UserRecentAcSubmissionResponse> fetchUserRecentAcSubmissions(
      String username, {int limit = 15}) async {
    final response = await _dioClient.post(
      AppConstants.graphqlEndpoint,
      data: {
        'query': GraphqlQueries.recentAcSubmissionsQuery,
        'variables': {'username': username, 'limit': limit},
        'operationName': 'recentAcSubmissions',
      },
    );
    return UserRecentAcSubmissionResponse.fromJson(response.data);
  }

  Future<ContestRatingHistogramResponse> fetchContestRatingHistogram() async {
    final response = await _dioClient.post(
      AppConstants.graphqlEndpoint,
      data: {
        'query': GraphqlQueries.contestRatingHistogramQuery,
        'variables': {},
        'operationName': 'contestRatingHistogram',
      },
    );
    return ContestRatingHistogramResponse.fromJson(response.data);
  }

  Future<UserBadgesResponse> fetchUserBadges(String username) async {
    final response = await _dioClient.post(
      AppConstants.graphqlEndpoint,
      data: {
        'query': GraphqlQueries.userBadgesQuery,
        'variables': {'username': username},
        'operationName': 'userBadges',
      },
    );
    return UserBadgesResponse.fromJson(response.data);
  }

  Future<DailyCodingChallengeResponse> fetchDailyCodingChallenge(
      int year, int month) async {
    final response = await _dioClient.post(
      AppConstants.graphqlEndpoint,
      data: {
        'query': GraphqlQueries.dailyCodingChallengeQuery,
        'variables': {'year': year, 'month': month},
        'operationName': 'dailyCodingQuestionRecords',
      },
    );
    return DailyCodingChallengeResponse.fromJson(response.data);
  }

  Future<QuestionsResponse> fetchQuestions({
    String? categorySlug,
    int limit = 50,
    int skip = 0,
    String? query,
    String? difficulty,
    String? status,
    List<String>? tags,
  }) async {
    final filters = <String, dynamic>{};
    if (query != null && query.isNotEmpty) filters['searchKeywords'] = query;
    if (difficulty != null) filters['difficulty'] = difficulty.toUpperCase();
    if (status != null) filters['status'] = status.toUpperCase();
    if (tags != null && tags.isNotEmpty) filters['tags'] = tags;

    final response = await _dioClient.post(
      AppConstants.graphqlEndpoint,
      data: {
        'query': GraphqlQueries.questionsQuery,
        'variables': {
          'categorySlug': categorySlug ?? '',
          'limit': limit,
          'skip': skip,
          'filters': filters,
        },
      },
    );
    return QuestionsResponse.fromJson(response.data);
  }

  Future<String> fetchQuestionDetails(String titleSlug) async {
    final response = await _dioClient.post(
      AppConstants.graphqlEndpoint,
      data: {
        'query': GraphqlQueries.questionContentQuery,
        'variables': {'titleSlug': titleSlug},
        'operationName': 'questionContent',
      },
    );
    // Extract content from response
    // The query returns { question: { content: ... } }
    final data = response.data['data']['question'];
    if (data != null) {
      return data['content'] as String? ?? '';
    }
    return '';
  }

  Future<SearchQuestionsResponse> searchQuestions({
    required String keyword,
    int limit = 50,
  }) async {
    final response = await _dioClient.post(
      AppConstants.graphqlEndpoint,
      data: {
        'query': GraphqlQueries.searchQuestionsQuery,
        'variables': {
          'searchKeyword': keyword,
          'limit': limit,
          'skip': 0,
          'categorySlug': '',
          'filters': null,
        },
        'operationName': 'problemsetQuestionListV2',
      },
    );
    return SearchQuestionsResponse.fromJson(response.data);
  }
}

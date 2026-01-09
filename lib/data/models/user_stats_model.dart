import 'package:json_annotation/json_annotation.dart';
import 'package:leet/data/models/user_model.dart';

part 'user_stats_model.g.dart';

@JsonSerializable()
class UserQuestionStatusData {
  final List<AllQuestionsCount>? allQuestionsCount;
  final LeetCodeUserInfo? matchedUser;

  UserQuestionStatusData({
    this.allQuestionsCount,
    this.matchedUser,
  });

  factory UserQuestionStatusData.fromJson(Map<String, dynamic> json) =>
      _$UserQuestionStatusDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserQuestionStatusDataToJson(this);
}

@JsonSerializable()
class UserQuestionStatusResponse {
  final UserQuestionStatusData? data;

  UserQuestionStatusResponse({this.data});

  factory UserQuestionStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$UserQuestionStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserQuestionStatusResponseToJson(this);
}

@JsonSerializable()
class AllQuestionsCount {
  final String? difficulty;
  final int? count;

  AllQuestionsCount({
    this.difficulty,
    this.count,
  });

  factory AllQuestionsCount.fromJson(Map<String, dynamic> json) =>
      _$AllQuestionsCountFromJson(json);

  Map<String, dynamic> toJson() => _$AllQuestionsCountToJson(this);
}

// SubmitStats and DifficultyCount moved to user_model.dart

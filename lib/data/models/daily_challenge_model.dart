import 'package:json_annotation/json_annotation.dart';

part 'daily_challenge_model.g.dart';

@JsonSerializable()
class DailyCodingChallengeResponse {
  final DailyCodingChallengeData? data;

  DailyCodingChallengeResponse({this.data});

  factory DailyCodingChallengeResponse.fromJson(Map<String, dynamic> json) =>
      _$DailyCodingChallengeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DailyCodingChallengeResponseToJson(this);
}

@JsonSerializable()
class DailyCodingChallengeData {
  @JsonKey(name: 'dailyCodingChallengeV2')
  final DailyCodingChallengeV2? dailyCodingChallengeV2;

  DailyCodingChallengeData({this.dailyCodingChallengeV2});

  factory DailyCodingChallengeData.fromJson(Map<String, dynamic> json) =>
      _$DailyCodingChallengeDataFromJson(json);

  Map<String, dynamic> toJson() => _$DailyCodingChallengeDataToJson(this);
}

@JsonSerializable()
class DailyCodingChallengeV2 {
  final List<DailyChallenge>? challenges;
  final List<WeeklyChallenge>? weeklyChallenges;

  DailyCodingChallengeV2({
    this.challenges,
    this.weeklyChallenges,
  });

  factory DailyCodingChallengeV2.fromJson(Map<String, dynamic> json) =>
      _$DailyCodingChallengeV2FromJson(json);

  Map<String, dynamic> toJson() => _$DailyCodingChallengeV2ToJson(this);
}

@JsonSerializable()
class DailyChallenge {
  final String? date;
  final String? userStatus;
  final String? link;
  final DailyChallengeQuestion? question;

  DailyChallenge({
    this.date,
    this.userStatus,
    this.link,
    this.question,
  });

  factory DailyChallenge.fromJson(Map<String, dynamic> json) =>
      _$DailyChallengeFromJson(json);

  Map<String, dynamic> toJson() => _$DailyChallengeToJson(this);
}

@JsonSerializable()
class DailyChallengeQuestion {
  final String? questionFrontendId;
  final String? title;
  final String? titleSlug;
  final String? difficulty;

  DailyChallengeQuestion({
    this.questionFrontendId,
    this.title,
    this.titleSlug,
    this.difficulty,
  });

  factory DailyChallengeQuestion.fromJson(Map<String, dynamic> json) =>
      _$DailyChallengeQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$DailyChallengeQuestionToJson(this);
}

@JsonSerializable()
class WeeklyChallenge {
  final String? date;
  final String? userStatus;
  final String? link;
  final WeeklyChallengeQuestion? question;

  WeeklyChallenge({
    this.date,
    this.userStatus,
    this.link,
    this.question,
  });

  factory WeeklyChallenge.fromJson(Map<String, dynamic> json) =>
      _$WeeklyChallengeFromJson(json);

  Map<String, dynamic> toJson() => _$WeeklyChallengeToJson(this);
}

@JsonSerializable()
class WeeklyChallengeQuestion {
  final String? questionFrontendId;
  final String? title;
  final String? titleSlug;
  final bool? isPaidOnly;
  final String? difficulty;

  WeeklyChallengeQuestion({
    this.questionFrontendId,
    this.title,
    this.titleSlug,
    this.isPaidOnly,
    this.difficulty,
  });

  factory WeeklyChallengeQuestion.fromJson(Map<String, dynamic> json) =>
      _$WeeklyChallengeQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$WeeklyChallengeQuestionToJson(this);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_challenge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyCodingChallengeResponse _$DailyCodingChallengeResponseFromJson(
        Map<String, dynamic> json) =>
    DailyCodingChallengeResponse(
      data: json['data'] == null
          ? null
          : DailyCodingChallengeData.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DailyCodingChallengeResponseToJson(
        DailyCodingChallengeResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

DailyCodingChallengeData _$DailyCodingChallengeDataFromJson(
        Map<String, dynamic> json) =>
    DailyCodingChallengeData(
      dailyCodingChallengeV2: json['dailyCodingChallengeV2'] == null
          ? null
          : DailyCodingChallengeV2.fromJson(
              json['dailyCodingChallengeV2'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DailyCodingChallengeDataToJson(
        DailyCodingChallengeData instance) =>
    <String, dynamic>{
      'dailyCodingChallengeV2': instance.dailyCodingChallengeV2,
    };

DailyCodingChallengeV2 _$DailyCodingChallengeV2FromJson(
        Map<String, dynamic> json) =>
    DailyCodingChallengeV2(
      challenges: (json['challenges'] as List<dynamic>?)
          ?.map((e) => DailyChallenge.fromJson(e as Map<String, dynamic>))
          .toList(),
      weeklyChallenges: (json['weeklyChallenges'] as List<dynamic>?)
          ?.map((e) => WeeklyChallenge.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DailyCodingChallengeV2ToJson(
        DailyCodingChallengeV2 instance) =>
    <String, dynamic>{
      'challenges': instance.challenges,
      'weeklyChallenges': instance.weeklyChallenges,
    };

DailyChallenge _$DailyChallengeFromJson(Map<String, dynamic> json) =>
    DailyChallenge(
      date: json['date'] as String?,
      userStatus: json['userStatus'] as String?,
      link: json['link'] as String?,
      question: json['question'] == null
          ? null
          : DailyChallengeQuestion.fromJson(
              json['question'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DailyChallengeToJson(DailyChallenge instance) =>
    <String, dynamic>{
      'date': instance.date,
      'userStatus': instance.userStatus,
      'link': instance.link,
      'question': instance.question,
    };

DailyChallengeQuestion _$DailyChallengeQuestionFromJson(
        Map<String, dynamic> json) =>
    DailyChallengeQuestion(
      questionFrontendId: json['questionFrontendId'] as String?,
      title: json['title'] as String?,
      titleSlug: json['titleSlug'] as String?,
      difficulty: json['difficulty'] as String?,
    );

Map<String, dynamic> _$DailyChallengeQuestionToJson(
        DailyChallengeQuestion instance) =>
    <String, dynamic>{
      'questionFrontendId': instance.questionFrontendId,
      'title': instance.title,
      'titleSlug': instance.titleSlug,
      'difficulty': instance.difficulty,
    };

WeeklyChallenge _$WeeklyChallengeFromJson(Map<String, dynamic> json) =>
    WeeklyChallenge(
      date: json['date'] as String?,
      userStatus: json['userStatus'] as String?,
      link: json['link'] as String?,
      question: json['question'] == null
          ? null
          : WeeklyChallengeQuestion.fromJson(
              json['question'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeeklyChallengeToJson(WeeklyChallenge instance) =>
    <String, dynamic>{
      'date': instance.date,
      'userStatus': instance.userStatus,
      'link': instance.link,
      'question': instance.question,
    };

WeeklyChallengeQuestion _$WeeklyChallengeQuestionFromJson(
        Map<String, dynamic> json) =>
    WeeklyChallengeQuestion(
      questionFrontendId: json['questionFrontendId'] as String?,
      title: json['title'] as String?,
      titleSlug: json['titleSlug'] as String?,
      isPaidOnly: json['isPaidOnly'] as bool?,
      difficulty: json['difficulty'] as String?,
    );

Map<String, dynamic> _$WeeklyChallengeQuestionToJson(
        WeeklyChallengeQuestion instance) =>
    <String, dynamic>{
      'questionFrontendId': instance.questionFrontendId,
      'title': instance.title,
      'titleSlug': instance.titleSlug,
      'isPaidOnly': instance.isPaidOnly,
      'difficulty': instance.difficulty,
    };

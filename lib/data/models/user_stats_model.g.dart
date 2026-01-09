// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserQuestionStatusData _$UserQuestionStatusDataFromJson(
        Map<String, dynamic> json) =>
    UserQuestionStatusData(
      allQuestionsCount: (json['allQuestionsCount'] as List<dynamic>?)
          ?.map((e) => AllQuestionsCount.fromJson(e as Map<String, dynamic>))
          .toList(),
      matchedUser: json['matchedUser'] == null
          ? null
          : LeetCodeUserInfo.fromJson(
              json['matchedUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserQuestionStatusDataToJson(
        UserQuestionStatusData instance) =>
    <String, dynamic>{
      'allQuestionsCount': instance.allQuestionsCount,
      'matchedUser': instance.matchedUser,
    };

UserQuestionStatusResponse _$UserQuestionStatusResponseFromJson(
        Map<String, dynamic> json) =>
    UserQuestionStatusResponse(
      data: json['data'] == null
          ? null
          : UserQuestionStatusData.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserQuestionStatusResponseToJson(
        UserQuestionStatusResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

AllQuestionsCount _$AllQuestionsCountFromJson(Map<String, dynamic> json) =>
    AllQuestionsCount(
      difficulty: json['difficulty'] as String?,
      count: (json['count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AllQuestionsCountToJson(AllQuestionsCount instance) =>
    <String, dynamic>{
      'difficulty': instance.difficulty,
      'count': instance.count,
    };

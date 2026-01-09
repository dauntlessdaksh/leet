// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submission_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRecentAcSubmissionResponse _$UserRecentAcSubmissionResponseFromJson(
        Map<String, dynamic> json) =>
    UserRecentAcSubmissionResponse(
      data: json['data'] == null
          ? null
          : UserRecentAcSubmissionData.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserRecentAcSubmissionResponseToJson(
        UserRecentAcSubmissionResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

UserRecentAcSubmissionData _$UserRecentAcSubmissionDataFromJson(
        Map<String, dynamic> json) =>
    UserRecentAcSubmissionData(
      recentAcSubmissionList: (json['recentAcSubmissionList'] as List<dynamic>?)
          ?.map(
              (e) => UserRecentAcSubmission.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserRecentAcSubmissionDataToJson(
        UserRecentAcSubmissionData instance) =>
    <String, dynamic>{
      'recentAcSubmissionList': instance.recentAcSubmissionList,
    };

UserRecentAcSubmission _$UserRecentAcSubmissionFromJson(
        Map<String, dynamic> json) =>
    UserRecentAcSubmission(
      id: json['id'] as String?,
      title: json['title'] as String?,
      titleSlug: json['titleSlug'] as String?,
      timestamp: json['timestamp'] as String?,
    );

Map<String, dynamic> _$UserRecentAcSubmissionToJson(
        UserRecentAcSubmission instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'titleSlug': instance.titleSlug,
      'timestamp': instance.timestamp,
    };

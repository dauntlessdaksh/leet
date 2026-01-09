// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contest_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllContestsResponse _$AllContestsResponseFromJson(Map<String, dynamic> json) =>
    AllContestsResponse(
      allContests: (json['allContests'] as List<dynamic>?)
          ?.map((e) => ContestItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllContestsResponseToJson(
        AllContestsResponse instance) =>
    <String, dynamic>{
      'allContests': instance.allContests,
    };

UpcomingContestsResponse _$UpcomingContestsResponseFromJson(
        Map<String, dynamic> json) =>
    UpcomingContestsResponse(
      count: (json['count'] as num?)?.toInt(),
      contests: (json['contests'] as List<dynamic>?)
          ?.map((e) => ContestItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UpcomingContestsResponseToJson(
        UpcomingContestsResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'contests': instance.contests,
    };

ContestItem _$ContestItemFromJson(Map<String, dynamic> json) => ContestItem(
      title: json['title'] as String?,
      titleSlug: json['titleSlug'] as String?,
      startTime: (json['startTime'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toInt(),
      originStartTime: (json['originStartTime'] as num?)?.toInt(),
      isVirtual: json['isVirtual'] as bool?,
      containsPremium: json['containsPremium'] as bool?,
    );

Map<String, dynamic> _$ContestItemToJson(ContestItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'titleSlug': instance.titleSlug,
      'startTime': instance.startTime,
      'duration': instance.duration,
      'originStartTime': instance.originStartTime,
      'isVirtual': instance.isVirtual,
      'containsPremium': instance.containsPremium,
    };

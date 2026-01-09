// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileCalendarResponse _$UserProfileCalendarResponseFromJson(
        Map<String, dynamic> json) =>
    UserProfileCalendarResponse(
      data: json['data'] == null
          ? null
          : UserProfileCalendarData.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserProfileCalendarResponseToJson(
        UserProfileCalendarResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

UserProfileCalendarData _$UserProfileCalendarDataFromJson(
        Map<String, dynamic> json) =>
    UserProfileCalendarData(
      matchedUser: json['matchedUser'] == null
          ? null
          : UserCalendarContainer.fromJson(
              json['matchedUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserProfileCalendarDataToJson(
        UserProfileCalendarData instance) =>
    <String, dynamic>{
      'matchedUser': instance.matchedUser,
    };

UserCalendarContainer _$UserCalendarContainerFromJson(
        Map<String, dynamic> json) =>
    UserCalendarContainer(
      userCalendar: json['userCalendar'] == null
          ? null
          : UserProfileCalendar.fromJson(
              json['userCalendar'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserCalendarContainerToJson(
        UserCalendarContainer instance) =>
    <String, dynamic>{
      'userCalendar': instance.userCalendar,
    };

UserProfileCalendar _$UserProfileCalendarFromJson(Map<String, dynamic> json) =>
    UserProfileCalendar(
      activeYears: (json['activeYears'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      streak: (json['streak'] as num?)?.toInt(),
      totalActiveDays: (json['totalActiveDays'] as num?)?.toInt(),
      dccBadges: (json['dccBadges'] as List<dynamic>?)
          ?.map((e) => DccBadge.fromJson(e as Map<String, dynamic>))
          .toList(),
      submissionCalendar: json['submissionCalendar'] as String?,
    );

Map<String, dynamic> _$UserProfileCalendarToJson(
        UserProfileCalendar instance) =>
    <String, dynamic>{
      'activeYears': instance.activeYears,
      'streak': instance.streak,
      'totalActiveDays': instance.totalActiveDays,
      'dccBadges': instance.dccBadges,
      'submissionCalendar': instance.submissionCalendar,
    };

DccBadge _$DccBadgeFromJson(Map<String, dynamic> json) => DccBadge(
      timestamp: (json['timestamp'] as num?)?.toInt(),
      badge: json['badge'] == null
          ? null
          : BadgeInfo.fromJson(json['badge'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DccBadgeToJson(DccBadge instance) => <String, dynamic>{
      'timestamp': instance.timestamp,
      'badge': instance.badge,
    };

BadgeInfo _$BadgeInfoFromJson(Map<String, dynamic> json) => BadgeInfo(
      name: json['name'] as String?,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$BadgeInfoToJson(BadgeInfo instance) => <String, dynamic>{
      'name': instance.name,
      'icon': instance.icon,
    };

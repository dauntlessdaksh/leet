import 'package:json_annotation/json_annotation.dart';

part 'calendar_model.g.dart';

@JsonSerializable()
class UserProfileCalendarResponse {
  final UserProfileCalendarData? data;

  UserProfileCalendarResponse({this.data});

  factory UserProfileCalendarResponse.fromJson(Map<String, dynamic> json) =>
      _$UserProfileCalendarResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileCalendarResponseToJson(this);
}

@JsonSerializable()
class UserProfileCalendarData {
  @JsonKey(name: 'matchedUser')
  final UserCalendarContainer? matchedUser;

  UserProfileCalendarData({this.matchedUser});

  factory UserProfileCalendarData.fromJson(Map<String, dynamic> json) =>
      _$UserProfileCalendarDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileCalendarDataToJson(this);
}

@JsonSerializable()
class UserCalendarContainer {
  @JsonKey(name: 'userCalendar')
  final UserProfileCalendar? userCalendar;

  UserCalendarContainer({this.userCalendar});

  factory UserCalendarContainer.fromJson(Map<String, dynamic> json) =>
      _$UserCalendarContainerFromJson(json);

  Map<String, dynamic> toJson() => _$UserCalendarContainerToJson(this);
}

@JsonSerializable()
class UserProfileCalendar {
  final List<int>? activeYears;
  final int? streak;
  final int? totalActiveDays;
  final List<DccBadge>? dccBadges;
  final String? submissionCalendar;

  UserProfileCalendar({
    this.activeYears,
    this.streak,
    this.totalActiveDays,
    this.dccBadges,
    this.submissionCalendar,
  });

  factory UserProfileCalendar.fromJson(Map<String, dynamic> json) =>
      _$UserProfileCalendarFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileCalendarToJson(this);
}

@JsonSerializable()
class DccBadge {
  final int? timestamp;
  final BadgeInfo? badge;

  DccBadge({
    this.timestamp,
    this.badge,
  });

  factory DccBadge.fromJson(Map<String, dynamic> json) =>
      _$DccBadgeFromJson(json);

  Map<String, dynamic> toJson() => _$DccBadgeToJson(this);
}

@JsonSerializable()
class BadgeInfo {
  final String? name;
  final String? icon;

  BadgeInfo({
    this.name,
    this.icon,
  });

  factory BadgeInfo.fromJson(Map<String, dynamic> json) =>
      _$BadgeInfoFromJson(json);

  Map<String, dynamic> toJson() => _$BadgeInfoToJson(this);
}

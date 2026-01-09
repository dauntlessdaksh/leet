import 'package:json_annotation/json_annotation.dart';

part 'badges_model.g.dart';

@JsonSerializable()
class UserBadgesResponse {
  final UserBadgesData? data;

  UserBadgesResponse({this.data});

  factory UserBadgesResponse.fromJson(Map<String, dynamic> json) =>
      _$UserBadgesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserBadgesResponseToJson(this);
}

@JsonSerializable()
class UserBadgesData {
  @JsonKey(name: 'matchedUser')
  final UserBadgesContainer? matchedUser;

  UserBadgesData({this.matchedUser});

  factory UserBadgesData.fromJson(Map<String, dynamic> json) =>
      _$UserBadgesDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserBadgesDataToJson(this);
}

@JsonSerializable()
class UserBadgesContainer {
  final List<Badge>? badges;
  final List<UpcomingBadge>? upcomingBadges;

  UserBadgesContainer({
    this.badges,
    this.upcomingBadges,
  });

  factory UserBadgesContainer.fromJson(Map<String, dynamic> json) =>
      _$UserBadgesContainerFromJson(json);

  Map<String, dynamic> toJson() => _$UserBadgesContainerToJson(this);
}

@JsonSerializable()
class Badge {
  final String? id;
  final String? name;
  final String? shortName;
  final String? displayName;
  final String? icon;
  final String? hoverText;
  final Medal? medal;
  final String? creationDate;
  final String? category;

  Badge({
    this.id,
    this.name,
    this.shortName,
    this.displayName,
    this.icon,
    this.hoverText,
    this.medal,
    this.creationDate,
    this.category,
  });

  factory Badge.fromJson(Map<String, dynamic> json) =>
      _$BadgeFromJson(json);

  Map<String, dynamic> toJson() => _$BadgeToJson(this);
}

@JsonSerializable()
class Medal {
  final String? slug;
  final MedalConfig? config;

  Medal({
    this.slug,
    this.config,
  });

  factory Medal.fromJson(Map<String, dynamic> json) =>
      _$MedalFromJson(json);

  Map<String, dynamic> toJson() => _$MedalToJson(this);
}

@JsonSerializable()
class MedalConfig {
  final String? iconGif;
  final String? iconGifBackground;

  MedalConfig({
    this.iconGif,
    this.iconGifBackground,
  });

  factory MedalConfig.fromJson(Map<String, dynamic> json) =>
      _$MedalConfigFromJson(json);

  Map<String, dynamic> toJson() => _$MedalConfigToJson(this);
}

@JsonSerializable()
class UpcomingBadge {
  final String? name;
  final String? icon;
  final int? progress;

  UpcomingBadge({
    this.name,
    this.icon,
    this.progress,
  });

  factory UpcomingBadge.fromJson(Map<String, dynamic> json) =>
      _$UpcomingBadgeFromJson(json);

  Map<String, dynamic> toJson() => _$UpcomingBadgeToJson(this);
}

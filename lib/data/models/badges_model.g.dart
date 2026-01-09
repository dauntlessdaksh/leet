// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badges_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBadgesResponse _$UserBadgesResponseFromJson(Map<String, dynamic> json) =>
    UserBadgesResponse(
      data: json['data'] == null
          ? null
          : UserBadgesData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserBadgesResponseToJson(UserBadgesResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

UserBadgesData _$UserBadgesDataFromJson(Map<String, dynamic> json) =>
    UserBadgesData(
      matchedUser: json['matchedUser'] == null
          ? null
          : UserBadgesContainer.fromJson(
              json['matchedUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserBadgesDataToJson(UserBadgesData instance) =>
    <String, dynamic>{
      'matchedUser': instance.matchedUser,
    };

UserBadgesContainer _$UserBadgesContainerFromJson(Map<String, dynamic> json) =>
    UserBadgesContainer(
      badges: (json['badges'] as List<dynamic>?)
          ?.map((e) => Badge.fromJson(e as Map<String, dynamic>))
          .toList(),
      upcomingBadges: (json['upcomingBadges'] as List<dynamic>?)
          ?.map((e) => UpcomingBadge.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserBadgesContainerToJson(
        UserBadgesContainer instance) =>
    <String, dynamic>{
      'badges': instance.badges,
      'upcomingBadges': instance.upcomingBadges,
    };

Badge _$BadgeFromJson(Map<String, dynamic> json) => Badge(
      id: json['id'] as String?,
      name: json['name'] as String?,
      shortName: json['shortName'] as String?,
      displayName: json['displayName'] as String?,
      icon: json['icon'] as String?,
      hoverText: json['hoverText'] as String?,
      medal: json['medal'] == null
          ? null
          : Medal.fromJson(json['medal'] as Map<String, dynamic>),
      creationDate: json['creationDate'] as String?,
      category: json['category'] as String?,
    );

Map<String, dynamic> _$BadgeToJson(Badge instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shortName': instance.shortName,
      'displayName': instance.displayName,
      'icon': instance.icon,
      'hoverText': instance.hoverText,
      'medal': instance.medal,
      'creationDate': instance.creationDate,
      'category': instance.category,
    };

Medal _$MedalFromJson(Map<String, dynamic> json) => Medal(
      slug: json['slug'] as String?,
      config: json['config'] == null
          ? null
          : MedalConfig.fromJson(json['config'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MedalToJson(Medal instance) => <String, dynamic>{
      'slug': instance.slug,
      'config': instance.config,
    };

MedalConfig _$MedalConfigFromJson(Map<String, dynamic> json) => MedalConfig(
      iconGif: json['iconGif'] as String?,
      iconGifBackground: json['iconGifBackground'] as String?,
    );

Map<String, dynamic> _$MedalConfigToJson(MedalConfig instance) =>
    <String, dynamic>{
      'iconGif': instance.iconGif,
      'iconGifBackground': instance.iconGifBackground,
    };

UpcomingBadge _$UpcomingBadgeFromJson(Map<String, dynamic> json) =>
    UpcomingBadge(
      name: json['name'] as String?,
      icon: json['icon'] as String?,
      progress: (json['progress'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UpcomingBadgeToJson(UpcomingBadge instance) =>
    <String, dynamic>{
      'name': instance.name,
      'icon': instance.icon,
      'progress': instance.progress,
    };

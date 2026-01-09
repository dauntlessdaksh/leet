// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeetCodeUserInfo _$LeetCodeUserInfoFromJson(Map<String, dynamic> json) =>
    LeetCodeUserInfo(
      username: json['username'] as String?,
      githubUrl: json['githubUrl'] as String?,
      twitterUrl: json['twitterUrl'] as String?,
      linkedinUrl: json['linkedinUrl'] as String?,
      contestBadge: json['contestBadge'] == null
          ? null
          : ContestBadge.fromJson(json['contestBadge'] as Map<String, dynamic>),
      profile: json['profile'] == null
          ? null
          : UserProfile.fromJson(json['profile'] as Map<String, dynamic>),
      submitStats: json['submitStats'] == null
          ? null
          : SubmitStats.fromJson(json['submitStats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LeetCodeUserInfoToJson(LeetCodeUserInfo instance) =>
    <String, dynamic>{
      'username': instance.username,
      'githubUrl': instance.githubUrl,
      'twitterUrl': instance.twitterUrl,
      'linkedinUrl': instance.linkedinUrl,
      'contestBadge': instance.contestBadge,
      'profile': instance.profile,
      'submitStats': instance.submitStats,
    };

SubmitStats _$SubmitStatsFromJson(Map<String, dynamic> json) => SubmitStats(
      acSubmissionNum: (json['acSubmissionNum'] as List<dynamic>?)
          ?.map((e) => DifficultyCount.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalSubmissionNum: (json['totalSubmissionNum'] as List<dynamic>?)
          ?.map((e) => DifficultyCount.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubmitStatsToJson(SubmitStats instance) =>
    <String, dynamic>{
      'acSubmissionNum': instance.acSubmissionNum,
      'totalSubmissionNum': instance.totalSubmissionNum,
    };

DifficultyCount _$DifficultyCountFromJson(Map<String, dynamic> json) =>
    DifficultyCount(
      difficulty: json['difficulty'] as String?,
      count: (json['count'] as num?)?.toInt(),
      submissions: (json['submissions'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DifficultyCountToJson(DifficultyCount instance) =>
    <String, dynamic>{
      'difficulty': instance.difficulty,
      'count': instance.count,
      'submissions': instance.submissions,
    };

ContestBadge _$ContestBadgeFromJson(Map<String, dynamic> json) => ContestBadge(
      name: json['name'] as String?,
      expired: json['expired'] as bool?,
      hoverText: json['hoverText'] as String?,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$ContestBadgeToJson(ContestBadge instance) =>
    <String, dynamic>{
      'name': instance.name,
      'expired': instance.expired,
      'hoverText': instance.hoverText,
      'icon': instance.icon,
    };

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      ranking: (json['ranking'] as num?)?.toInt(),
      userAvatar: json['userAvatar'] as String?,
      realName: json['realName'] as String?,
      aboutMe: json['aboutMe'] as String?,
      school: json['school'] as String?,
      websites: (json['websites'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      countryName: json['countryName'] as String?,
      company: json['company'] as String?,
      jobTitle: json['jobTitle'] as String?,
      skillTags: (json['skillTags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      postViewCount: (json['postViewCount'] as num?)?.toInt(),
      postViewCountDiff: (json['postViewCountDiff'] as num?)?.toInt(),
      reputation: (json['reputation'] as num?)?.toInt(),
      reputationDiff: (json['reputationDiff'] as num?)?.toInt(),
      solutionCount: (json['solutionCount'] as num?)?.toInt(),
      solutionCountDiff: (json['solutionCountDiff'] as num?)?.toInt(),
      categoryDiscussCount: (json['categoryDiscussCount'] as num?)?.toInt(),
      categoryDiscussCountDiff:
          (json['categoryDiscussCountDiff'] as num?)?.toInt(),
      certificationLevel: json['certificationLevel'] as String?,
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'ranking': instance.ranking,
      'userAvatar': instance.userAvatar,
      'realName': instance.realName,
      'aboutMe': instance.aboutMe,
      'school': instance.school,
      'websites': instance.websites,
      'countryName': instance.countryName,
      'company': instance.company,
      'jobTitle': instance.jobTitle,
      'skillTags': instance.skillTags,
      'postViewCount': instance.postViewCount,
      'postViewCountDiff': instance.postViewCountDiff,
      'reputation': instance.reputation,
      'reputationDiff': instance.reputationDiff,
      'solutionCount': instance.solutionCount,
      'solutionCountDiff': instance.solutionCountDiff,
      'categoryDiscussCount': instance.categoryDiscussCount,
      'categoryDiscussCountDiff': instance.categoryDiscussCountDiff,
      'certificationLevel': instance.certificationLevel,
    };

UserInfoResponse _$UserInfoResponseFromJson(Map<String, dynamic> json) =>
    UserInfoResponse(
      data: json['data'] == null
          ? null
          : UserInfoData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserInfoResponseToJson(UserInfoResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

UserInfoData _$UserInfoDataFromJson(Map<String, dynamic> json) => UserInfoData(
      matchedUser: json['matchedUser'] == null
          ? null
          : LeetCodeUserInfo.fromJson(
              json['matchedUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserInfoDataToJson(UserInfoData instance) =>
    <String, dynamic>{
      'matchedUser': instance.matchedUser,
    };

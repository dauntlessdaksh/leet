import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class LeetCodeUserInfo {
  final String? username;
  final String? githubUrl;
  final String? twitterUrl;
  final String? linkedinUrl;
  final ContestBadge? contestBadge;
  final UserProfile? profile;
  final SubmitStats? submitStats;

  LeetCodeUserInfo({
    this.username,
    this.githubUrl,
    this.twitterUrl,
    this.linkedinUrl,
    this.contestBadge,
    this.profile,
    this.submitStats,
  });

  factory LeetCodeUserInfo.fromJson(Map<String, dynamic> json) =>
      _$LeetCodeUserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$LeetCodeUserInfoToJson(this);
}

@JsonSerializable()
class SubmitStats {
  final List<DifficultyCount>? acSubmissionNum;
  final List<DifficultyCount>? totalSubmissionNum;

  SubmitStats({
    this.acSubmissionNum,
    this.totalSubmissionNum,
  });

  factory SubmitStats.fromJson(Map<String, dynamic> json) =>
      _$SubmitStatsFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitStatsToJson(this);
}

@JsonSerializable()
class DifficultyCount {
  final String? difficulty;
  final int? count;
  final int? submissions;

  DifficultyCount({
    this.difficulty,
    this.count,
    this.submissions,
  });

  factory DifficultyCount.fromJson(Map<String, dynamic> json) =>
      _$DifficultyCountFromJson(json);

  Map<String, dynamic> toJson() => _$DifficultyCountToJson(this);
}

@JsonSerializable()
class ContestBadge {
  final String? name;
  final bool? expired;
  final String? hoverText;
  final String? icon;

  ContestBadge({
    this.name,
    this.expired,
    this.hoverText,
    this.icon,
  });

  factory ContestBadge.fromJson(Map<String, dynamic> json) =>
      _$ContestBadgeFromJson(json);

  Map<String, dynamic> toJson() => _$ContestBadgeToJson(this);
}

@JsonSerializable()
class UserProfile {
  final int? ranking;
  final String? userAvatar;
  final String? realName;
  final String? aboutMe;
  final String? school;
  final List<String>? websites;
  final String? countryName;
  final String? company;
  final String? jobTitle;
  final List<String>? skillTags;
  final int? postViewCount;
  final int? postViewCountDiff;
  final int? reputation;
  final int? reputationDiff;
  final int? solutionCount;
  final int? solutionCountDiff;
  final int? categoryDiscussCount;
  final int? categoryDiscussCountDiff;
  final String? certificationLevel;

  UserProfile({
    this.ranking,
    this.userAvatar,
    this.realName,
    this.aboutMe,
    this.school,
    this.websites,
    this.countryName,
    this.company,
    this.jobTitle,
    this.skillTags,
    this.postViewCount,
    this.postViewCountDiff,
    this.reputation,
    this.reputationDiff,
    this.solutionCount,
    this.solutionCountDiff,
    this.categoryDiscussCount,
    this.categoryDiscussCountDiff,
    this.certificationLevel,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}

@JsonSerializable()
class UserInfoResponse {
  final UserInfoData? data;

  UserInfoResponse({this.data});

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$UserInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoResponseToJson(this);
}

@JsonSerializable()
class UserInfoData {
  @JsonKey(name: 'matchedUser')
  final LeetCodeUserInfo? matchedUser;

  UserInfoData({this.matchedUser});

  factory UserInfoData.fromJson(Map<String, dynamic> json) =>
      _$UserInfoDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoDataToJson(this);
}

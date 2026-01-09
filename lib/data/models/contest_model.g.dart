// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contest_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserContestRankingResponse _$UserContestRankingResponseFromJson(
        Map<String, dynamic> json) =>
    UserContestRankingResponse(
      data: json['data'] == null
          ? null
          : UserContestRankingData.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserContestRankingResponseToJson(
        UserContestRankingResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

UserContestRankingData _$UserContestRankingDataFromJson(
        Map<String, dynamic> json) =>
    UserContestRankingData(
      userContestRanking: json['userContestRanking'] == null
          ? null
          : UserContestRanking.fromJson(
              json['userContestRanking'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserContestRankingDataToJson(
        UserContestRankingData instance) =>
    <String, dynamic>{
      'userContestRanking': instance.userContestRanking,
    };

UserContestRanking _$UserContestRankingFromJson(Map<String, dynamic> json) =>
    UserContestRanking(
      attendedContestsCount: (json['attendedContestsCount'] as num?)?.toInt(),
      rating: (json['rating'] as num?)?.toDouble(),
      globalRanking: (json['globalRanking'] as num?)?.toInt(),
      totalParticipants: (json['totalParticipants'] as num?)?.toInt(),
      topPercentage: (json['topPercentage'] as num?)?.toDouble(),
      badge: json['badge'] == null
          ? null
          : ContestBadgeSimple.fromJson(json['badge'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserContestRankingToJson(UserContestRanking instance) =>
    <String, dynamic>{
      'attendedContestsCount': instance.attendedContestsCount,
      'rating': instance.rating,
      'globalRanking': instance.globalRanking,
      'totalParticipants': instance.totalParticipants,
      'topPercentage': instance.topPercentage,
      'badge': instance.badge,
    };

ContestBadgeSimple _$ContestBadgeSimpleFromJson(Map<String, dynamic> json) =>
    ContestBadgeSimple(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ContestBadgeSimpleToJson(ContestBadgeSimple instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

ContestRatingHistogramResponse _$ContestRatingHistogramResponseFromJson(
        Map<String, dynamic> json) =>
    ContestRatingHistogramResponse(
      data: json['data'] == null
          ? null
          : ContestRatingHistogramData.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContestRatingHistogramResponseToJson(
        ContestRatingHistogramResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

ContestRatingHistogramData _$ContestRatingHistogramDataFromJson(
        Map<String, dynamic> json) =>
    ContestRatingHistogramData(
      contestRatingHistogram: (json['contestRatingHistogram'] as List<dynamic>?)
          ?.map((e) =>
              ContestRatingHistogramItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContestRatingHistogramDataToJson(
        ContestRatingHistogramData instance) =>
    <String, dynamic>{
      'contestRatingHistogram': instance.contestRatingHistogram,
    };

ContestRatingHistogramItem _$ContestRatingHistogramItemFromJson(
        Map<String, dynamic> json) =>
    ContestRatingHistogramItem(
      userCount: (json['userCount'] as num?)?.toInt(),
      ratingStart: (json['ratingStart'] as num?)?.toInt(),
      ratingEnd: (json['ratingEnd'] as num?)?.toInt(),
      topPercentage: (json['topPercentage'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ContestRatingHistogramItemToJson(
        ContestRatingHistogramItem instance) =>
    <String, dynamic>{
      'userCount': instance.userCount,
      'ratingStart': instance.ratingStart,
      'ratingEnd': instance.ratingEnd,
      'topPercentage': instance.topPercentage,
    };

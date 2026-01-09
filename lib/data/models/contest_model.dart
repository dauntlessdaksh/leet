import 'package:json_annotation/json_annotation.dart';

part 'contest_model.g.dart';

@JsonSerializable()
class UserContestRankingResponse {
  final UserContestRankingData? data;

  UserContestRankingResponse({this.data});

  factory UserContestRankingResponse.fromJson(Map<String, dynamic> json) =>
      _$UserContestRankingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserContestRankingResponseToJson(this);
}

@JsonSerializable()
class UserContestRankingData {
  final UserContestRanking? userContestRanking;

  UserContestRankingData({this.userContestRanking});

  factory UserContestRankingData.fromJson(Map<String, dynamic> json) =>
      _$UserContestRankingDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserContestRankingDataToJson(this);
}

@JsonSerializable()
class UserContestRanking {
  final int? attendedContestsCount;
  final double? rating;
  final int? globalRanking;
  final int? totalParticipants;
  final double? topPercentage;
  final ContestBadgeSimple? badge;

  UserContestRanking({
    this.attendedContestsCount,
    this.rating,
    this.globalRanking,
    this.totalParticipants,
    this.topPercentage,
    this.badge,
  });

  factory UserContestRanking.fromJson(Map<String, dynamic> json) =>
      _$UserContestRankingFromJson(json);

  Map<String, dynamic> toJson() => _$UserContestRankingToJson(this);
}

@JsonSerializable()
class ContestBadgeSimple {
  final String? name;

  ContestBadgeSimple({this.name});

  factory ContestBadgeSimple.fromJson(Map<String, dynamic> json) =>
      _$ContestBadgeSimpleFromJson(json);

  Map<String, dynamic> toJson() => _$ContestBadgeSimpleToJson(this);
}

@JsonSerializable()
class ContestRatingHistogramResponse {
  final ContestRatingHistogramData? data;

  ContestRatingHistogramResponse({this.data});

  factory ContestRatingHistogramResponse.fromJson(Map<String, dynamic> json) =>
      _$ContestRatingHistogramResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContestRatingHistogramResponseToJson(this);
}

@JsonSerializable()
class ContestRatingHistogramData {
  final List<ContestRatingHistogramItem>? contestRatingHistogram;

  ContestRatingHistogramData({this.contestRatingHistogram});

  factory ContestRatingHistogramData.fromJson(Map<String, dynamic> json) =>
      _$ContestRatingHistogramDataFromJson(json);

  Map<String, dynamic> toJson() => _$ContestRatingHistogramDataToJson(this);
}

@JsonSerializable()
class ContestRatingHistogramItem {
  final int? userCount;
  final int? ratingStart;
  final int? ratingEnd;
  final double? topPercentage;

  ContestRatingHistogramItem({
    this.userCount,
    this.ratingStart,
    this.ratingEnd,
    this.topPercentage,
  });

  factory ContestRatingHistogramItem.fromJson(Map<String, dynamic> json) =>
      _$ContestRatingHistogramItemFromJson(json);

  Map<String, dynamic> toJson() => _$ContestRatingHistogramItemToJson(this);
}

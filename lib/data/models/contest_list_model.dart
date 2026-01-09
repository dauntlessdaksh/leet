import 'package:json_annotation/json_annotation.dart';

part 'contest_list_model.g.dart';

@JsonSerializable()
class AllContestsResponse {
  final List<ContestItem>? allContests;

  AllContestsResponse({this.allContests});

  factory AllContestsResponse.fromJson(Map<String, dynamic> json) =>
      _$AllContestsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllContestsResponseToJson(this);
}

@JsonSerializable()
class UpcomingContestsResponse {
  final int? count;
  final List<ContestItem>? contests;

  UpcomingContestsResponse({this.count, this.contests});

  factory UpcomingContestsResponse.fromJson(Map<String, dynamic> json) =>
      _$UpcomingContestsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpcomingContestsResponseToJson(this);
}

@JsonSerializable()
class ContestItem {
  final String? title;
  final String? titleSlug;
  final int? startTime;
  final int? duration;
  final int? originStartTime;
  final bool? isVirtual;
  final bool? containsPremium;

  ContestItem({
    this.title,
    this.titleSlug,
    this.startTime,
    this.duration,
    this.originStartTime,
    this.isVirtual,
    this.containsPremium,
  });

  factory ContestItem.fromJson(Map<String, dynamic> json) =>
      _$ContestItemFromJson(json);

  Map<String, dynamic> toJson() => _$ContestItemToJson(this);
}

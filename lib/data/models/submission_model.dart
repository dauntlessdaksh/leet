import 'package:json_annotation/json_annotation.dart';

part 'submission_model.g.dart';

@JsonSerializable()
class UserRecentAcSubmissionResponse {
  final UserRecentAcSubmissionData? data;

  UserRecentAcSubmissionResponse({this.data});

  factory UserRecentAcSubmissionResponse.fromJson(Map<String, dynamic> json) =>
      _$UserRecentAcSubmissionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserRecentAcSubmissionResponseToJson(this);
}

@JsonSerializable()
class UserRecentAcSubmissionData {
  @JsonKey(name: 'recentAcSubmissionList')
  final List<UserRecentAcSubmission>? recentAcSubmissionList;

  UserRecentAcSubmissionData({this.recentAcSubmissionList});

  factory UserRecentAcSubmissionData.fromJson(Map<String, dynamic> json) =>
      _$UserRecentAcSubmissionDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserRecentAcSubmissionDataToJson(this);
}

@JsonSerializable()
class UserRecentAcSubmission {
  final String? id;
  final String? title;
  final String? titleSlug;
  final dynamic timestamp;

  UserRecentAcSubmission({
    this.id,
    this.title,
    this.titleSlug,
    this.timestamp,
  });

  factory UserRecentAcSubmission.fromJson(Map<String, dynamic> json) =>
      _$UserRecentAcSubmissionFromJson(json);

  Map<String, dynamic> toJson() => _$UserRecentAcSubmissionToJson(this);
}

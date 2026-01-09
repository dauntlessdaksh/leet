import 'package:json_annotation/json_annotation.dart';

part 'question_model.g.dart';

@JsonSerializable()
class Question {
  final double acRate;
  final String difficulty;
  final double? freqBar;
  @JsonKey(name: 'frontendQuestionId')
  final String frontendQuestionId;
  @JsonKey(defaultValue: false)
  final bool isFavor;
  @JsonKey(defaultValue: false)
  final bool paidOnly;
  final String? status;
  final String title;
  final String titleSlug;
  @JsonKey(defaultValue: [])
  final List<TopicTag> topicTags;
  @JsonKey(defaultValue: false)
  final bool hasSolution;
  @JsonKey(defaultValue: false)
  final bool hasVideoSolution;

  Question({
    required this.acRate,
    required this.difficulty,
    this.freqBar,
    required this.frontendQuestionId,
    this.isFavor = false,
    this.paidOnly = false,
    this.status,
    required this.title,
    required this.titleSlug,
    this.topicTags = const [],
    this.hasSolution = false,
    this.hasVideoSolution = false,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}

@JsonSerializable()
class TopicTag {
  final String name;
  final String? id;
  final String slug;

  TopicTag({
    required this.name,
    this.id,
    required this.slug,
  });

  factory TopicTag.fromJson(Map<String, dynamic> json) =>
      _$TopicTagFromJson(json);

  Map<String, dynamic> toJson() => _$TopicTagToJson(this);
}

@JsonSerializable()
class QuestionsResponse {
  final ProblemsetQuestionListResponseData data;

  QuestionsResponse({required this.data});

  factory QuestionsResponse.fromJson(Map<String, dynamic> json) =>
      _$QuestionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionsResponseToJson(this);
}

@JsonSerializable()
class ProblemsetQuestionListResponseData {
  @JsonKey(name: 'problemsetQuestionList')
  final ProblemsetQuestionListData problemsetQuestionList;

  ProblemsetQuestionListResponseData({required this.problemsetQuestionList});

  factory ProblemsetQuestionListResponseData.fromJson(Map<String, dynamic> json) =>
      _$ProblemsetQuestionListResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProblemsetQuestionListResponseDataToJson(this);
}

@JsonSerializable()
class ProblemsetQuestionListData {
  final int total;
  final List<Question> questions;

  ProblemsetQuestionListData({
    required this.total,
    required this.questions,
  });

  factory ProblemsetQuestionListData.fromJson(Map<String, dynamic> json) =>
      _$ProblemsetQuestionListDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProblemsetQuestionListDataToJson(this);
}

@JsonSerializable()
class SearchQuestionNode {
  final String id;
  final String titleSlug;
  final String title;
  final String? translatedTitle;
  @JsonKey(name: 'questionFrontendId')
  final String questionFrontendId;
  final bool paidOnly;
  final String difficulty;
  final List<SearchTopicTag> topicTags;
  final String? status;
  @JsonKey(defaultValue: false)
  final bool isInMyFavorites;
  final double? frequency;
  final double acRate;
  final double? contestPoint;

  SearchQuestionNode({
    required this.id,
    required this.titleSlug,
    required this.title,
    this.translatedTitle,
    required this.questionFrontendId,
    required this.paidOnly,
    required this.difficulty,
    required this.topicTags,
    this.status,
    this.isInMyFavorites = false,
    this.frequency,
    required this.acRate,
    this.contestPoint,
  });

  factory SearchQuestionNode.fromJson(Map<String, dynamic> json) =>
      _$SearchQuestionNodeFromJson(json);

  Map<String, dynamic> toJson() => _$SearchQuestionNodeToJson(this);
}

@JsonSerializable()
class SearchTopicTag {
  final String name;
  final String slug;
  final String? nameTranslated;

  SearchTopicTag({
    required this.name,
    required this.slug,
    this.nameTranslated,
  });

  factory SearchTopicTag.fromJson(Map<String, dynamic> json) =>
      _$SearchTopicTagFromJson(json);

  Map<String, dynamic> toJson() => _$SearchTopicTagToJson(this);
}

@JsonSerializable()
class SearchQuestionsResponse {
  final SearchQuestionsResponseData data;

  SearchQuestionsResponse({required this.data});

  factory SearchQuestionsResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchQuestionsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchQuestionsResponseToJson(this);
}

@JsonSerializable()
class SearchQuestionsResponseData {
  @JsonKey(name: 'problemsetQuestionListV2')
  final SearchQuestionsListData problemsetQuestionListV2;

  SearchQuestionsResponseData({required this.problemsetQuestionListV2});

  factory SearchQuestionsResponseData.fromJson(Map<String, dynamic> json) =>
      _$SearchQuestionsResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$SearchQuestionsResponseDataToJson(this);
}

@JsonSerializable()
class SearchQuestionsListData {
  final List<SearchQuestionNode> questions;
  final int totalLength;
  final int finishedLength;
  final bool hasMore;

  SearchQuestionsListData({
    required this.questions,
    required this.totalLength,
    required this.finishedLength,
    required this.hasMore,
  });

  factory SearchQuestionsListData.fromJson(Map<String, dynamic> json) =>
      _$SearchQuestionsListDataFromJson(json);

  Map<String, dynamic> toJson() => _$SearchQuestionsListDataToJson(this);
}

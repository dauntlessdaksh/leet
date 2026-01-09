// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      acRate: (json['acRate'] as num).toDouble(),
      difficulty: json['difficulty'] as String,
      freqBar: (json['freqBar'] as num?)?.toDouble(),
      frontendQuestionId: json['frontendQuestionId'] as String,
      isFavor: json['isFavor'] as bool? ?? false,
      paidOnly: json['paidOnly'] as bool? ?? false,
      status: json['status'] as String?,
      title: json['title'] as String,
      titleSlug: json['titleSlug'] as String,
      topicTags: (json['topicTags'] as List<dynamic>?)
              ?.map((e) => TopicTag.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      hasSolution: json['hasSolution'] as bool? ?? false,
      hasVideoSolution: json['hasVideoSolution'] as bool? ?? false,
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'acRate': instance.acRate,
      'difficulty': instance.difficulty,
      'freqBar': instance.freqBar,
      'frontendQuestionId': instance.frontendQuestionId,
      'isFavor': instance.isFavor,
      'paidOnly': instance.paidOnly,
      'status': instance.status,
      'title': instance.title,
      'titleSlug': instance.titleSlug,
      'topicTags': instance.topicTags,
      'hasSolution': instance.hasSolution,
      'hasVideoSolution': instance.hasVideoSolution,
    };

TopicTag _$TopicTagFromJson(Map<String, dynamic> json) => TopicTag(
      name: json['name'] as String,
      id: json['id'] as String?,
      slug: json['slug'] as String,
    );

Map<String, dynamic> _$TopicTagToJson(TopicTag instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'slug': instance.slug,
    };

QuestionsResponse _$QuestionsResponseFromJson(Map<String, dynamic> json) =>
    QuestionsResponse(
      data: ProblemsetQuestionListResponseData.fromJson(
          json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuestionsResponseToJson(QuestionsResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

ProblemsetQuestionListResponseData _$ProblemsetQuestionListResponseDataFromJson(
        Map<String, dynamic> json) =>
    ProblemsetQuestionListResponseData(
      problemsetQuestionList: ProblemsetQuestionListData.fromJson(
          json['problemsetQuestionList'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProblemsetQuestionListResponseDataToJson(
        ProblemsetQuestionListResponseData instance) =>
    <String, dynamic>{
      'problemsetQuestionList': instance.problemsetQuestionList,
    };

ProblemsetQuestionListData _$ProblemsetQuestionListDataFromJson(
        Map<String, dynamic> json) =>
    ProblemsetQuestionListData(
      total: (json['total'] as num).toInt(),
      questions: (json['questions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProblemsetQuestionListDataToJson(
        ProblemsetQuestionListData instance) =>
    <String, dynamic>{
      'total': instance.total,
      'questions': instance.questions,
    };

SearchQuestionNode _$SearchQuestionNodeFromJson(Map<String, dynamic> json) =>
    SearchQuestionNode(
      id: json['id'] as String,
      titleSlug: json['titleSlug'] as String,
      title: json['title'] as String,
      translatedTitle: json['translatedTitle'] as String?,
      questionFrontendId: json['questionFrontendId'] as String,
      paidOnly: json['paidOnly'] as bool,
      difficulty: json['difficulty'] as String,
      topicTags: (json['topicTags'] as List<dynamic>)
          .map((e) => SearchTopicTag.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
      isInMyFavorites: json['isInMyFavorites'] as bool? ?? false,
      frequency: (json['frequency'] as num?)?.toDouble(),
      acRate: (json['acRate'] as num).toDouble(),
      contestPoint: (json['contestPoint'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SearchQuestionNodeToJson(SearchQuestionNode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'titleSlug': instance.titleSlug,
      'title': instance.title,
      'translatedTitle': instance.translatedTitle,
      'questionFrontendId': instance.questionFrontendId,
      'paidOnly': instance.paidOnly,
      'difficulty': instance.difficulty,
      'topicTags': instance.topicTags,
      'status': instance.status,
      'isInMyFavorites': instance.isInMyFavorites,
      'frequency': instance.frequency,
      'acRate': instance.acRate,
      'contestPoint': instance.contestPoint,
    };

SearchTopicTag _$SearchTopicTagFromJson(Map<String, dynamic> json) =>
    SearchTopicTag(
      name: json['name'] as String,
      slug: json['slug'] as String,
      nameTranslated: json['nameTranslated'] as String?,
    );

Map<String, dynamic> _$SearchTopicTagToJson(SearchTopicTag instance) =>
    <String, dynamic>{
      'name': instance.name,
      'slug': instance.slug,
      'nameTranslated': instance.nameTranslated,
    };

SearchQuestionsResponse _$SearchQuestionsResponseFromJson(
        Map<String, dynamic> json) =>
    SearchQuestionsResponse(
      data: SearchQuestionsResponseData.fromJson(
          json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchQuestionsResponseToJson(
        SearchQuestionsResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

SearchQuestionsResponseData _$SearchQuestionsResponseDataFromJson(
        Map<String, dynamic> json) =>
    SearchQuestionsResponseData(
      problemsetQuestionListV2: SearchQuestionsListData.fromJson(
          json['problemsetQuestionListV2'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchQuestionsResponseDataToJson(
        SearchQuestionsResponseData instance) =>
    <String, dynamic>{
      'problemsetQuestionListV2': instance.problemsetQuestionListV2,
    };

SearchQuestionsListData _$SearchQuestionsListDataFromJson(
        Map<String, dynamic> json) =>
    SearchQuestionsListData(
      questions: (json['questions'] as List<dynamic>)
          .map((e) => SearchQuestionNode.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalLength: (json['totalLength'] as num).toInt(),
      finishedLength: (json['finishedLength'] as num).toInt(),
      hasMore: json['hasMore'] as bool,
    );

Map<String, dynamic> _$SearchQuestionsListDataToJson(
        SearchQuestionsListData instance) =>
    <String, dynamic>{
      'questions': instance.questions,
      'totalLength': instance.totalLength,
      'finishedLength': instance.finishedLength,
      'hasMore': instance.hasMore,
    };

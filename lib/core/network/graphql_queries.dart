class GraphqlQueries {
  static const String userExistsQuery = r'''
     query userInfo($username: String!) {
         matchedUser(username: $username) {
             contestBadge {
                 name
                 expired
                 hoverText
                 icon
             }
             username
             githubUrl
             twitterUrl
             linkedinUrl
             profile {
                 ranking
                 userAvatar
                 realName
                 aboutMe
                 school
                 websites
                 countryName
                 company
                 jobTitle
                 skillTags
                 postViewCount
                 postViewCountDiff
                 reputation
                 reputationDiff
                 solutionCount
                 solutionCountDiff
                 categoryDiscussCount
                 categoryDiscussCountDiff
                 certificationLevel
             }
         }
     }
  ''';

  static const String userQuestionCountQuery = r'''
    query userSessionProgress($username: String!) {
      allQuestionsCount {
        difficulty
        count
      }
      matchedUser(username: $username) {
        submitStats {
          acSubmissionNum {
            difficulty
            count
            submissions
          }
          totalSubmissionNum {
            difficulty
            count
            submissions
          }
        }
      }
    }
  ''';

  static const String currentDataQuery = r'''
    query currentTimestamp {
      currentTimestamp
    }
  ''';

  static const String userProfileCalendarQuery = r'''
    query userProfileCalendar($username: String!, $year: Int) {
      matchedUser(username: $username) {
        userCalendar(year: $year) {
          activeYears
          streak
          totalActiveDays
          dccBadges {
            timestamp
            badge {
              name
              icon
            }
          }
          submissionCalendar
        }
      }
    }
  ''';

  static const String userContestRankingQuery = r'''
    query userContestRankingInfo($username: String!) {
      userContestRanking(username: $username) {
        attendedContestsCount
        rating
        globalRanking
        totalParticipants
        topPercentage
        badge {
          name
        }
      }
    }
  ''';

  static const String recentAcSubmissionsQuery = r'''
    query recentAcSubmissions($username: String!, $limit: Int!) {
      recentAcSubmissionList(username: $username, limit: $limit) {
        id
        title
        titleSlug
        timestamp
      }
    }
  ''';

  static const String contestRatingHistogramQuery = r'''
    query contestRatingHistogram {
      contestRatingHistogram {
        userCount
        ratingStart
        ratingEnd
        topPercentage
      }
    }
  ''';

  static const String userBadgesQuery = r'''
    query userBadges($username: String!) {
      matchedUser(username: $username) {
        badges {
          id
          name
          shortName
          displayName
          icon
          hoverText
          medal {
            slug
            config {
              iconGif
              iconGifBackground
            }
          }
          creationDate
          category
        }
        upcomingBadges {
          name
          icon
          progress
        }
      }
    }
  ''';

  static const String dailyCodingChallengeQuery = r'''
    query dailyCodingQuestionRecords($year: Int!, $month: Int!) {
      dailyCodingChallengeV2(year: $year, month: $month) {
        challenges {
          date
          userStatus
          link
          question {
            questionFrontendId
            title
            titleSlug
            difficulty
          }
        }
        weeklyChallenges {
          date
          userStatus
          link
          question {
            questionFrontendId
            title
            titleSlug
            isPaidOnly
            difficulty
          }
        }
      }
    }
  ''';

  static const String questionsQuery = r'''
    query problemsetQuestionList($categorySlug: String, $limit: Int, $skip: Int, $filters: QuestionListFilterInput) {
        problemsetQuestionList: questionList(
            categorySlug: $categorySlug
            limit: $limit
            skip: $skip
            filters: $filters
        ) {
            total: totalNum
            questions: data {
                acRate
                difficulty
                freqBar
                frontendQuestionId: questionFrontendId
                isFavor
                paidOnly: isPaidOnly
                status
                title
                titleSlug
                topicTags {
                    name
                    id
                    slug
                }
                hasSolution
                hasVideoSolution
            }
        }
    }
  ''';

  static const String searchQuestionsQuery = r'''
    query problemsetQuestionListV2($filters: QuestionFilterInput, $limit: Int, $searchKeyword: String, $skip: Int, $sortBy: QuestionSortByInput, $categorySlug: String) {
      problemsetQuestionListV2(
        filters: $filters
        limit: $limit
        searchKeyword: $searchKeyword
        skip: $skip
        sortBy: $sortBy
        categorySlug: $categorySlug
      ) {
        questions {
          id
          titleSlug
          title
          translatedTitle
          questionFrontendId
          paidOnly
          difficulty
          topicTags {
            name
            slug
            nameTranslated
          }
          status
          isInMyFavorites
          frequency
          acRate
          contestPoint
        }
        totalLength
        finishedLength
        hasMore
      }
    }
  ''';
  
  static const String questionContentQuery = r'''
    query questionContent($titleSlug: String!) {
      question(titleSlug: $titleSlug) {
        content
        mysqlSchemas
        dataSchemas
        similarQuestions
        mysqlSchemas
        dataSchemas
      }
    }
  ''';
}

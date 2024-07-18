import 'package:flutter/material.dart';
import 'package:nextintern_mobile/models/question_model.dart';
import 'package:nextintern_mobile/models/answer_model.dart';
import 'package:nextintern_mobile/services/question_service.dart';
import 'package:nextintern_mobile/widgets/custom_app_bar.dart';
import 'package:nextintern_mobile/widgets/question_cart.dart';
import 'package:nextintern_mobile/services/answer_service.dart';
import 'package:nextintern_mobile/utils/notification_service.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<List<QuestionModel>> _questionListFuture;
  late Future<List<AnswerModel>> _answerListFuture;

  @override
  void initState() {
    super.initState();
    _loadQuestionsAndAnswers();
    NotificationService.initializeNotifications();
    _checkUnansweredQuestions();
  }

  Future<void> _loadQuestionsAndAnswers() async {
    _questionListFuture = QuestionService.getAllQuestions();
    _answerListFuture = AnswerService.getAllAnswers();
  }

  Future<void> _checkUnansweredQuestions() async {
    List<QuestionModel> questions = await _questionListFuture;
    List<AnswerModel> answers = await _answerListFuture;

    int unansweredCount = 0;
    for (var question in questions) {
      bool hasAnswer = answers.any(
          (answer) => answer.campaignQuestionId == question.campaignQuestionId);
      if (!hasAnswer) {
        unansweredCount++;
      }
    }

    if (unansweredCount > 0) {
      NotificationService.showNotification(1, 'Bạn có câu hỏi chưa trả lời',
          'Bạn hiện còn $unansweredCount câu hỏi chưa hoàn thành');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Bọc Scaffold bằng WillPopScope
      onWillPop: () async {
        _loadQuestionsAndAnswers(); // Reload dữ liệu khi back
        return true; // Cho phép back
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: GradientAppBar(
            title: 'Question',
          ),
        ),
        body: FutureBuilder<List<QuestionModel>>(
          future: _questionListFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              List<QuestionModel> questionList = snapshot.data!;
              return FutureBuilder<List<AnswerModel>>(
                future: _answerListFuture,
                builder: (context, answerSnapshot) {
                  if (answerSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (answerSnapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (answerSnapshot.hasData) {
                    List<AnswerModel> answerList = answerSnapshot.data!;
                    return ListView.builder(
                      itemCount: questionList.length,
                      itemBuilder: (context, index) {
                        final question = questionList[index];
                        AnswerModel? correspondingAnswer;

                        if (answerSnapshot.hasData) {
                          correspondingAnswer = answerSnapshot.data!.firstWhere(
                            (answer) =>
                                answer.campaignQuestionId ==
                                question.campaignQuestionId,
                            orElse: () => AnswerModel(),
                          );
                        }

                        return QuestionCart(
                          question: question,
                          answer: correspondingAnswer,
                          scaffoldKey: _scaffoldKey,
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('No answers found'));
                  }
                },
              );
            } else {
              return const Center(child: Text('No questions found'));
            }
          },
        ),
      ),
    );
  }
}

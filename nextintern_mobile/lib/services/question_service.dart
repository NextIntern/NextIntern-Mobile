import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nextintern_mobile/consts/api_consts.dart';
import 'package:nextintern_mobile/models/answer_model.dart';
import 'package:nextintern_mobile/models/question_model.dart';
import 'package:nextintern_mobile/services/answer_service.dart';
import 'package:nextintern_mobile/services/auth_service.dart';

class QuestionService {
  static Future<List<QuestionModel>> getAllQuestions() async {
    String? token = await AuthService.getToken();

    if (token != null) {
      List<AnswerModel> answers = await AnswerService.getAllAnswers();

      var uri = Uri.https(BASE_INTERN_URL, "/api/v1/campaign-question/all");
      var response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'] as List;
        List<QuestionModel> questions = QuestionModel.questionsFromJson(data);

        for (var question in questions) {
          bool hasAnswer = answers.any((answer) =>
              answer.campaignQuestionId == question.campaignQuestionId);
          question.status = hasAnswer;
        }

        return questions;
      } else {
        throw Exception('Failed to load questions: ${response.body}');
      }
    } else {
      throw Exception('Unauthorized');
    }
  }
}

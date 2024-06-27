import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nextintern_mobile/consts/api_consts.dart';
import 'package:nextintern_mobile/models/question_model.dart';

class QuestionService {
  static Future<List<QuestionModel>> getAllQuestions() async {
    var uri = Uri.http(BASE_URL, "/questions");
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as List;
      return QuestionModel.questionsFromJson(data);
    } else {
      throw Exception('Failed to load questions');
    }
  }
}

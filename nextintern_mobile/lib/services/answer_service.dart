import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nextintern_mobile/consts/api_consts.dart';
import 'package:nextintern_mobile/models/answer_model.dart';
import 'package:nextintern_mobile/services/auth_service.dart';

class AnswerService {
  static Future<List<AnswerModel>> getAllAnswers() async {
    String? token = await AuthService.getToken();

    if (token != null) {
      var uri =
          Uri.https(BASE_INTERN_URL, "/api/v1/campaign-question-response/all");
      var response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'] as List;
        return AnswerModel.answersFromJson(data);
      } else {
        throw Exception('Failed to load answers: ${response.body}');
      }
    } else {
      throw Exception('Unauthorized');
    }
  }
}

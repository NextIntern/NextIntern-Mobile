import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nextintern_mobile/consts/api_consts.dart';
import 'package:nextintern_mobile/models/criteria_model.dart';
import 'package:nextintern_mobile/models/profile_model.dart';
import 'package:nextintern_mobile/models/question_model.dart';

class ApiHandler {
  static Future<List<QuestionModel>> getAllQuestions() async {
    var uri = Uri.http(BASE_URL, "/questions");
    var response = await http
        .get(uri); // Thay đổi điều này thành IP của máy của bạn nếu cần

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as List;
      return QuestionModel.questionsFromJson(data);
    } else {
      throw Exception('Failed to load questions');
    }
  }

  static Future<List<CriteriaModel>> getAllCriteria() async {
    var uri = Uri.http(BASE_URL, "/criteria");
    var response = await http
        .get(uri); // Thay đổi điều này thành IP của máy của bạn nếu cần

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as List;
      return CriteriaModel.criteriaFromJson(data);
    } else {
      throw Exception('Failed to load questions');
    }
  }

  static Future<ProfileModel> getProfile() async {
    var uri = Uri.http(BASE_URL, "/profile");
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return ProfileModel.profileFromJson(data);
    } else {
      throw Exception('Failed to load profile');
    }
  }
}

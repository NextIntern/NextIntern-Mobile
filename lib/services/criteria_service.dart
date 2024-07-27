import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nextintern_mobile/consts/api_consts.dart';
import 'package:nextintern_mobile/models/criteria_model.dart';

class CriteriaService {
  static Future<List<CriteriaModel>> getAllCriteria() async {
    var uri = Uri.http(BASE_URL, "/criteria");
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as List;
      return CriteriaModel.criteriaFromJson(data);
    } else {
      throw Exception('Failed to load criteria');
    }
  }
}

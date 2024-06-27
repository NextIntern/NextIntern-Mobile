import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nextintern_mobile/consts/api_consts.dart';
import 'package:nextintern_mobile/models/profile_model.dart';

class ProfileService {
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

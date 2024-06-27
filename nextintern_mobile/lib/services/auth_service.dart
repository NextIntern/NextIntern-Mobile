import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nextintern_mobile/consts/api_consts.dart';
import 'package:nextintern_mobile/models/login_model.dart';

class AuthService {
  static Future<LoginModel> login(String username, String password) async {
    var uri = Uri.https(BASE_INTERN_URL, "/api/v1/auth/signin");
    // HTTP vs HTTPS là 2 cái riêng, tách ra
    var response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "username": username,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return LoginModel.fromJson(data);
    } else {
      throw Exception('Failed to login');
    }
  }

  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}

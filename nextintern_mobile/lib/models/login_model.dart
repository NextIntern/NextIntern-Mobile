class LoginModel {
  Token? token;

  LoginModel({this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'] != null ? Token.fromJson(json['token']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (token != null) {
      data['token'] = token!.toJson();
    }
    return data;
  }
}

class Token {
  String? accessToken;
  String? refreshToken;

  Token({this.accessToken, this.refreshToken});

  Token.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    return data;
  }
}

class AnswerModel {
  String? campaignQuestionResponseId;
  String? campaignQuestionId;
  String? internId;
  String? response;
  int? rating;

  AnswerModel({
    this.campaignQuestionResponseId,
    this.campaignQuestionId,
    this.internId,
    this.response,
    this.rating,
  });

  AnswerModel.fromJson(Map<String, dynamic> json) {
    campaignQuestionResponseId = json['campaignQuestionResponseId'];
    campaignQuestionId = json['campaignQuestionId'];
    // Kiểm tra xem JSON có chứa internId hay không
    if (json['internId'] != null) {
      internId = json['internId']; // Lấy internId từ JSON
    } else {
      internId = "eda49f0d-c75e-46c4-a171-d77706e7017c"; // Gán giá trị mặc định
    }
    response = json['response'];
    rating = json['rating'];
  }

  static List<AnswerModel> answersFromJson(List<dynamic> answersJson) {
    return answersJson.map((data) {
      return AnswerModel.fromJson(data);
    }).toList();
  }
}

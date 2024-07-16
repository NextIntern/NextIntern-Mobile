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
    internId = json['internId'];
    response = json['response'];
    rating = json['rating'];
  }

  static List<AnswerModel> answersFromJson(List<dynamic> answersJson) {
    return answersJson.map((data) {
      return AnswerModel.fromJson(data);
    }).toList();
  }
}

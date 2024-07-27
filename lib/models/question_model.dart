class QuestionModel {
  String? campaignQuestionId;
  String? campaignId;
  String? question;
  String? createDate;
  String? modifyDate;
  bool? status;

  QuestionModel({
    this.campaignQuestionId,
    this.campaignId,
    this.question,
    this.createDate,
    this.modifyDate,
    this.status,
  });

  QuestionModel.fromJson(Map<String, dynamic> json) {
    campaignQuestionId = json['campaignQuestionId'];
    campaignId = json['campaignId'];
    question = json['question'];
    createDate = json['createDate'];
    modifyDate = json['modifyDate'];
  }

  static List<QuestionModel> questionsFromJson(List<dynamic> questionsJson) {
    return questionsJson.map((data) {
      return QuestionModel.fromJson(data);
    }).toList();
  }
}

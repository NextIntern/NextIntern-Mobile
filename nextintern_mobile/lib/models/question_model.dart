class QuestionModel {
  String? questionsId;
  String? questions;
  bool? status;
  String? id;

  QuestionModel({this.questionsId, this.questions, this.status, this.id});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    questionsId = json['questionsId'];
    questions = json['questions'];
    status = json['status'];
    id = json['id'];
  }

  static List<QuestionModel> questionsFromJson(List<dynamic> questionsJson) {
    return questionsJson.map((data) {
      return QuestionModel.fromJson(data);
    }).toList();
  }
}

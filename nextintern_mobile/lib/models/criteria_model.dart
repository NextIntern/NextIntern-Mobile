class CriteriaModel {
  String? criteriaId;
  String? criteria;
  String? evaluateFromMentor;
  bool? start;
  bool? isChecked;
  String? id;

  CriteriaModel(
      {this.criteriaId,
      this.criteria,
      this.evaluateFromMentor,
      this.start,
      this.isChecked,
      this.id});

  CriteriaModel.fromJson(Map<String, dynamic> json) {
    criteriaId = json['criteriaId'];
    criteria = json['criteria'];
    evaluateFromMentor = json['evaluateFromMentor'];
    start = json['start'];
    isChecked = json['isChecked'];
    id = json['id'];
  }

  static List<CriteriaModel> criteriaFromJson(List<dynamic> criteriaJson) {
    return criteriaJson.map((data) {
      return CriteriaModel.fromJson(data);
    }).toList();
  }
}

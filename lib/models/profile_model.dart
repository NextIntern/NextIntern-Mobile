class ProfileModel {
  String? name;
  int? age;
  String? occupation;
  String? location;
  String? skills;
  String? languages;

  ProfileModel(
      {this.name,
      this.age,
      this.occupation,
      this.location,
      this.skills,
      this.languages});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    occupation = json['occupation'];
    location = json['location'];
    skills = json['skills'];
    languages = json['languages'];
  }

  static ProfileModel profileFromJson(Map<String, dynamic> profileJson) {
    return ProfileModel.fromJson(profileJson);
  }
}

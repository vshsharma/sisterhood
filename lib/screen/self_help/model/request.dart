class SafetyPlan {
  String count;
  String question;
  String option;
  String description;

  SafetyPlan({this.count, this.question, this.option, this.description});

  SafetyPlan.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    question = json['question'];
    option = json['option'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['count'] = this.count;
    data['question'] = this.question;
    data['option'] = this.option;
    data['description'] = this.description;
    return data;
  }
}


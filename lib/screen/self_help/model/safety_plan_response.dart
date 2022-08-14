class SafetyPlanResponse {
  String question1;
  String question2;
  String question3;
  String question4;
  String question5;
  String question6;
  String question7;
  String question8;
  String question9;
  String question10;
  String question11;

  SafetyPlanResponse(
      {this.question1,
        this.question2,
        this.question3,
        this.question4,
        this.question5,
        this.question6,
        this.question7,
        this.question8,
        this.question9,
        this.question10,
        this.question11});

  SafetyPlanResponse.fromJson(Map<String, dynamic> json) {
    question1 = json['question1'];
    question2 = json['question2'];
    question3 = json['question3'];
    question4 = json['question4'];
    question5 = json['question5'];
    question6 = json['question6'];
    question7 = json['question7'];
    question8 = json['question8'];
    question9 = json['question9'];
    question10 = json['question10'];
    question11 = json['question11'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question1'] = this.question1;
    data['question2'] = this.question2;
    data['question3'] = this.question3;
    data['question4'] = this.question4;
    data['question5'] = this.question5;
    data['question6'] = this.question6;
    data['question7'] = this.question7;
    data['question8'] = this.question8;
    data['question9'] = this.question9;
    data['question10'] = this.question10;
    data['question11'] = this.question11;
    return data;
  }
}
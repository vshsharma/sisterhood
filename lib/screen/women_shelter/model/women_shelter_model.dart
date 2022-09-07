class WomenShelterModel {
  String phone;
  String webURL;
  String address;
  String additionalInfo;
  String coordinate;
  String email;
  String name;

  WomenShelterModel(
      {this.phone,
      this.webURL,
      this.address,
      this.additionalInfo,
      this.coordinate,
      this.email,
      this.name});

  WomenShelterModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    webURL = json['web_URL'];
    address = json['address'];
    additionalInfo = json['additional_Info'];
    coordinate = json['coordinate'];
    email = json['email'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['web_URL'] = this.webURL;
    data['address'] = this.address;
    data['additional_Info'] = this.additionalInfo;
    data['coordinate'] = this.coordinate;
    data['email'] = this.email;
    data['name'] = this.name;
    return data;
  }
}

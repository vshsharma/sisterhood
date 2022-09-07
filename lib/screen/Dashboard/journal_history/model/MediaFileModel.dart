class MediaFileModel {
  String url;
  String path;
  String name;
  int size;
  bool upload;

  MediaFileModel({this.url, this.path, this.name, this.size, this.upload});

  MediaFileModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    path = json['path'];
    name = json['name'];
    size = json['size'];
    upload = json['upload'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['path'] = this.path;
    data['name'] = this.name;
    data['size'] = this.size;
    data['upload'] = this.upload;
    return data;
  }
}

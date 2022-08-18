class MediaFileModel {
  String url;
  String path;
  String name;
  int size;
  bool upload;

  MediaFileModel(
      {this.url = "",
      this.size = 0,
      this.path = "",
      this.name = "",
      this.upload = false});
}

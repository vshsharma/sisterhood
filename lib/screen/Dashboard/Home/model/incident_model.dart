class IncidentModel {
  String audio;
  String circumstances;
  String dateStamp;
  String datewithhappen;
  String document;
  String happen;
  String outsideareaspecify;
  String partnerundertheinfluence;
  String picture;
  String popuptext;
  String resultincident;
  String undertheinfluence;
  String video;
  String whathappend;
  String wouldyouliketorecord;

  IncidentModel(
      {this.audio,
        this.circumstances,
        this.dateStamp,
        this.datewithhappen,
        this.document,
        this.happen,
        this.outsideareaspecify,
        this.partnerundertheinfluence,
        this.picture,
        this.popuptext,
        this.resultincident,
        this.undertheinfluence,
        this.video,
        this.whathappend,
        this.wouldyouliketorecord});

  IncidentModel.fromJson(Map<String, dynamic> json) {
    audio = json['audio'];
    circumstances = json['circumstances'];
    dateStamp = json['dateStamp'];
    datewithhappen = json['datewithhappen'];
    document = json['document'];
    happen = json['happen'];
    outsideareaspecify = json['outsideareaspecify'];
    partnerundertheinfluence = json['partnerundertheinfluence'];
    picture = json['picture'];
    popuptext = json['popuptext'];
    resultincident = json['resultincident'];
    undertheinfluence = json['undertheinfluence'];
    video = json['video'];
    whathappend = json['whathappend'];
    wouldyouliketorecord = json['wouldyouliketorecord'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['audio'] = this.audio;
    data['circumstances'] = this.circumstances;
    data['dateStamp'] = this.dateStamp;
    data['datewithhappen'] = this.datewithhappen;
    data['document'] = this.document;
    data['happen'] = this.happen;
    data['outsideareaspecify'] = this.outsideareaspecify;
    data['partnerundertheinfluence'] = this.partnerundertheinfluence;
    data['picture'] = this.picture;
    data['popuptext'] = this.popuptext;
    data['resultincident'] = this.resultincident;
    data['undertheinfluence'] = this.undertheinfluence;
    data['video'] = this.video;
    data['whathappend'] = this.whathappend;
    data['wouldyouliketorecord'] = this.wouldyouliketorecord;
    return data;
  }
}
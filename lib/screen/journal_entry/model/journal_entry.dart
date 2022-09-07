import 'package:file_picker/file_picker.dart';

class Journal {
  List<String> checkedAbuseType = [];
  List<String> checkWhereItHappen = [];
  List<String> checkPartnerUnderInfluence = [];
  List<String> checkIfYouUnderInfluence = [];
  List<PlatformFile> selectedImages = [];
  List<PlatformFile> selectedVideos = [];
  List<PlatformFile> selectedAudio = [];
  String checkMedicalAssistant = '';
  String whatHappenText = '';
  String circumstancesText = '';
  String areaSpecifyText = '';
  String medicalAssistantText = '';
  String dateTimeText = '';
}

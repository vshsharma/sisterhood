import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JournalMetaData {
  List<String> abuseCategory(BuildContext context) {
    return [
      AppLocalizations.of(context).abuse_category_1,
      AppLocalizations.of(context).abuse_category_2,
      AppLocalizations.of(context).abuse_category_3,
      AppLocalizations.of(context).abuse_category_4,
      AppLocalizations.of(context).abuse_category_5
    ];
  }

  List<String> subCategory(BuildContext context) {
    return [
      AppLocalizations.of(context).sub_cat_1,
      AppLocalizations.of(context).sub_cat_2,
      AppLocalizations.of(context).sub_cat_3,
      AppLocalizations.of(context).sub_cat_4,
      AppLocalizations.of(context).sub_cat_5
    ];
  }

  List<String> incidentPlace(BuildContext context) {
    return [
      AppLocalizations.of(context).incident_place_1,
      AppLocalizations.of(context).incident_place_2,
      AppLocalizations.of(context).incident_place_3,
      AppLocalizations.of(context).incident_place_4,
      AppLocalizations.of(context).incident_place_5,
      AppLocalizations.of(context).incident_place_6
    ];
  }

  List<String> underInfluenceOption(BuildContext context) {
    return [
      AppLocalizations.of(context).under_influence_option_1,
      AppLocalizations.of(context).under_influence_option_2,
      AppLocalizations.of(context).under_influence_option_3,
      AppLocalizations.of(context).under_influence_option_4
    ];
  }

  List<String> seekedMedicalAttentionOption(BuildContext context) {
    return [
      AppLocalizations.of(context).seeked_medical_attention_option_1,
      AppLocalizations.of(context).seeked_medical_attention_option_2
    ];
  }
}

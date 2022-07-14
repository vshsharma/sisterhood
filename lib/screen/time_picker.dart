import 'package:flutter/material.dart';

class CustomTimePicker {

  Future<TimeOfDay> showTimePicker({
    BuildContext context,
    TimeOfDay initialTime,
    TransitionBuilder builder,
    bool useRootNavigator = true,
    TimePickerEntryMode initialEntryMode = TimePickerEntryMode.dial,
    String cancelText,
    String confirmText,
    String helpText,
    String errorInvalidText,
    String hourLabelText,
    String minuteLabelText,
    RouteSettings routeSettings,
    EntryModeChangeCallback onEntryModeChanged,
    Offset anchorPoint,
  }) async {
    assert(context != null);
    assert(initialTime != null);
    assert(useRootNavigator != null);
    assert(initialEntryMode != null);
    assert(debugCheckHasMaterialLocalizations(context));

    final Widget dialog = TimePickerDialog(
      initialTime: initialTime,
      initialEntryMode: initialEntryMode,
      cancelText: cancelText,
      confirmText: confirmText,
      helpText: helpText,
      errorInvalidText: errorInvalidText,
      hourLabelText: hourLabelText,
      minuteLabelText: minuteLabelText,
      onEntryModeChanged: onEntryModeChanged,
    );
    return showDialog<TimeOfDay>(
      context: context,
      useRootNavigator: useRootNavigator,
      builder: (BuildContext context) {
        return builder == null ? dialog : builder(context, dialog);
      },
      routeSettings: routeSettings,
    );
  }
}

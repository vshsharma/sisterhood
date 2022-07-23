import 'package:flutter/material.dart';
import 'package:sisterhood_app/utill/color_resources.dart';
import 'package:sisterhood_app/utill/dimension.dart';
import 'package:sisterhood_app/utill/styles.dart';
import 'grouped_buttons_orientation.dart';

class CheckboxGroup extends StatefulWidget {
  final List<String> labels;
  final List<String> subLabels;
  final bool showDescription;
  final List<String> checked;
  final List<String> disabled;
  final void Function(bool isChecked, String label, int index) onChange;

  /// Called when the user makes a selection.
  final void Function(List<String> selected) onSelected;

  /// The style to use for the labels.
  final TextStyle labelStyle;

  /// Specifies the orientation to display elements.
  final GroupedButtonsOrientation orientation;

  /// Called when needed to build a CheckboxGroup element.
  final Widget Function(Checkbox checkBox, Text label, int index) itemBuilder;

  //THESE FIELDS ARE FOR THE CHECKBOX

  /// The color to use when a Checkbox is checked.
  final Color activeColor;

  /// The color to use for the check icon when a Checkbox is checked.
  final Color checkColor;

  /// If true the checkbox's value can be true, false, or null.
  final bool tristate;


  //SPACING STUFF

  /// Empty space in which to inset the CheckboxGroup.
  final EdgeInsetsGeometry padding;

  /// Empty space surrounding the CheckboxGroup.
  final EdgeInsetsGeometry margin;

  CheckboxGroup({
    Key key,
    @required this.labels,
    this.subLabels,
    this.showDescription = false,
    this.checked,
    this.disabled,
    this.onChange,
    this.onSelected,
    this.labelStyle = courierFont16W600,
    this.activeColor, //defaults to toggleableActiveColor,
    this.checkColor = const Color(0xFFFFFFFF),
    this.tristate = false,
    this.orientation = GroupedButtonsOrientation.VERTICAL,
    this.itemBuilder,
    this.padding = const EdgeInsets.all(0.0),
    this.margin = const EdgeInsets.all(0.0),
  }) : super(key: key);

  @override
  _CheckboxGroupState createState() => _CheckboxGroupState();
}

class _CheckboxGroupState extends State<CheckboxGroup> {
  List<String> _selected = [];

  @override
  void initState() {
    super.initState();

    _selected = widget.checked ?? [];

  }

  @override
  Widget build(BuildContext context) {

    //set the selected to the checked (if not null)
    if (widget.checked != null) {
      _selected = [];
      _selected.addAll(widget.checked); //use add all to prevent a shallow copy
    }

    List<Widget> content = [];

    for (int i = 0; i < widget.labels.length; i++) {
      Checkbox cb = Checkbox(
        value: _selected.contains(widget.labels.elementAt(i)),
        onChanged: (widget.disabled != null &&
                widget.disabled.contains(widget.labels.elementAt(i)))
            ? null
            : (bool isChecked) => onChanged(isChecked, i),
        checkColor: widget.checkColor,
        activeColor:
            widget.activeColor ?? Theme.of(context).toggleableActiveColor,
        tristate: widget.tristate,
      );

      Text t = Text(widget.labels.elementAt(i),
          maxLines: null,
          style: (widget.disabled != null &&
                  widget.disabled.contains(widget.labels.elementAt(i)))
              ? widget.labelStyle
                  .apply(color: Theme.of(context).disabledColor)
                  .copyWith(fontFamily: 'Courier')
              : widget.labelStyle);
      Expanded cn;
      if (widget.showDescription) {
        cn = Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: dim_14, bottom: dim_6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                t,
                SizedBox(height: dim_4,),
                Text(widget.subLabels.elementAt(i),
                    style: (widget.disabled != null &&
                            widget.disabled
                                .contains(widget.labels.elementAt(i)))
                        ? widget.labelStyle
                            .apply(color: Theme.of(context).disabledColor)
                            .copyWith(color: ColorResources.grey)
                        : widget.labelStyle
                            .copyWith(color: ColorResources.grey))
              ],
            ),
          ),
        );
      }

      //use user defined method to build
      if (widget.itemBuilder != null)
        content.add(widget.itemBuilder(cb, widget.showDescription ? cn : t, i));
      else {
        content.add(Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(width: 2.0),
              cb,
              const SizedBox(width: 6.0),
              widget.showDescription ? cn : Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: dim_14),
                  child: t,
                ),
              ),
            ]));
        //otherwise, use predefined method of building

        // //vertical orientation means Column with Row inside
        // if (widget.orientation == GroupedButtonsOrientation.VERTICAL) {
        //   content.add(Row(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       children: <Widget>[
        //     SizedBox(width: 2.0),
        //     cb,
        //     SizedBox(width: 6.0),
        //     widget.showDescription ? cn : Expanded(child: t),
        //   ]));
        // } else {
        //   //horizontal orientation means Row with Column inside
        //
        //   content.add(Column(children: <Widget>[
        //     cb,
        //     const SizedBox(width: 6.0),
        //     widget.showDescription? cn: Expanded(child: t),
        //   ]));
        //
        // }
      }
    }

    return Container(
      padding: widget.padding,
      margin: widget.margin,
      child: widget.orientation == GroupedButtonsOrientation.VERTICAL ? Column(children: content) : Row(children: content),
    );
  }

  void onChanged(bool isChecked, int i) {
    bool isAlreadyContained = _selected.contains(widget.labels.elementAt(i));

    if (mounted) {
      setState(() {
        if (!isChecked && isAlreadyContained) {
          _selected.remove(widget.labels.elementAt(i));
        } else if (isChecked && !isAlreadyContained) {
          _selected.add(widget.labels.elementAt(i));
        }

        if (widget.onChange != null)
          widget.onChange(isChecked, widget.labels.elementAt(i), i);
        if (widget.onSelected != null) widget.onSelected(_selected);
      });
    }
  }
}

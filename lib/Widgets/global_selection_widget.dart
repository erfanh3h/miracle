import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Resources/app_consts.dart';
import 'package:miracle/Widgets/global/global_input_box.dart';

class GlobalSelectionWidget extends StatefulWidget {
  const GlobalSelectionWidget({
    super.key,
    required this.selectionData,
    required this.onTap,
    required this.value,
    required this.label,
    this.currentFocusNode,
    this.needTranslate = false,
    this.isEnable = true,
    this.fontSize,
  });

  final List<String> selectionData;
  final Function(String?) onTap;
  final String? value;
  final String label;
  final FocusNode? currentFocusNode;
  final bool needTranslate;
  final double? fontSize;
  final bool isEnable;

  @override
  State<GlobalSelectionWidget> createState() => _GlobalSelectionWidgetState();
}

class _GlobalSelectionWidgetState extends State<GlobalSelectionWidget> {
  GlobalKey? dropdownButtonKey = GlobalKey();
  final TextEditingController textController = TextEditingController();
  void openDropdown() {
    GestureDetector? detector;
    void searchForGestureDetector(BuildContext? element) {
      element?.visitChildElements((element) {
        if (element.widget is GestureDetector) {
          detector = element.widget as GestureDetector?;
        } else {
          searchForGestureDetector(element);
        }
      });
    }

    searchForGestureDetector(dropdownButtonKey?.currentContext);
    assert(detector != null);

    detector?.onTap?.call();
  }

  @override
  void initState() {
    textController.text = widget.value ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dropdown = DropdownButton<String>(
      key: dropdownButtonKey,
      items: widget.selectionData
          .map(
            (label) => DropdownMenuItem(
              value: label,
              child: Container(
                transform: Matrix4.translationValues(0.0, 0.h, 0.0),
                // height: 50.h,
                child: Text(
                  label,
                  style: TextStyle(
                    color: context.theme.colorScheme.secondary,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w500,
                    fontFamily: FontFamilies.vazir,
                  ),
                ),
              ),
            ),
          )
          .toList(),
      value: widget.value,
      onChanged: (String? value) {
        widget.onTap(value);
        textController.text = value!.tr;
      },
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Offstage(child: dropdown),
        InkWell(
          onTap: widget.isEnable ? openDropdown : null,
          child: GlobalInputBox(
            label: widget.label,
            controller: textController,
            enable: false,
            fontSize: widget.fontSize ?? 15,
            minLines: 2,
            height: 50.h,
            icon: Icon(
              Icons.arrow_drop_down_rounded,
              color: context.theme.colorScheme.secondary,
              size: 15.r,
            ),
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}

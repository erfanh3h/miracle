import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';

class InputBox extends StatefulWidget {
  const InputBox({
    final Key? key,
    required this.label,
    required this.controller,
    // this.onTapFunction,
    this.changeFunction,
    this.enable = true,
    this.textType = TextInputType.text,
    this.readOnly = false,
    this.hideContent = false,
    this.minLines = 1,
    this.maxLines = 8,
    this.mustFill = false,
    this.textDirection = TextDirection.rtl,
    this.validator,
    this.maxLength,
    this.textInputAction,
  }) : super(key: key);

  // hint of input box
  final String label;

  // change function that called when value changed
  final Function(String)? changeFunction;

  //controller of inputbox
  final TextEditingController? controller;

  // inputbox is enabled
  final bool enable;

  // input type
  final TextInputType textType;

  // is inputbox read only or not
  final bool readOnly;

  // min lines of inputbox
  final int minLines;

  // max lines of inputbox
  final int? maxLines;

  // this inputbox most have value
  final bool mustFill;

  // validator of input box
  final Function? validator;

  // max length of input box
  final int? maxLength;

  // text direction of input box
  final TextDirection textDirection;

  // password mode
  final bool hideContent;

  final TextInputAction? textInputAction;

  @override
  InputBoxState createState() => InputBoxState();
}

class InputBoxState extends State<InputBox> {
  bool isTapped = false;

  Function? validator;
  @override
  void initState() {
    //this use for set default validator
    if (widget.validator != null) {
      validator = widget.validator;
    } else {
      validator = (value) {
        return null;
      };
    }
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: Directionality(
        textDirection: widget.textDirection,
        child: FocusScope(
          onFocusChange: (final val) {
            setState(() {
              isTapped = val;
            });
          },
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.hideContent,
            enabled: widget.enable,
            readOnly: widget.readOnly,
            onChanged: widget.changeFunction,
            validator: (val) => validator!(val),
            maxLength: widget.maxLength,
            decoration: InputDecoration(
              counterText: '',
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              contentPadding: AppSpacings.s10All,
              hintText: widget.label,
              hintStyle:
                  Get.textTheme.caption!.copyWith(color: AppColors.grey500),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
            ),
            // cursorColor: widget.color,
            style: Get.textTheme.bodyText1,
            keyboardType: widget.textType,
            textInputAction: widget.textInputAction,
            minLines: widget.minLines,
            maxLines: widget.maxLines,
          ),
        ),
      ),
    );
  }
}

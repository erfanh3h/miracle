import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getxify/getxify.dart';
import 'package:miracle/Resources/app_consts.dart';

class GlobalInputBox extends StatefulWidget {
  const GlobalInputBox({
    super.key,
    required this.label,
    required this.controller,
    // this.onTapFunction,
    this.changeFunction,
    this.enable = true,
    this.textType = TextInputType.text,
    this.readOnly = false,
    this.hideContent = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.mustFill = false,
    this.textDirection = TextDirection.rtl,
    this.hintDirection = TextDirection.rtl,
    this.validator,
    this.maxLength,
    this.textInputAction,
    this.onlyEnglishLetters = false,
    this.textAlign = TextAlign.start,
    this.currentFocusNode,
    this.nextFocusNode,
    this.fontFamily = FontFamilies.vazir,
    this.fontSize = 15,
    this.icon,
    this.backgroundColor,
    this.height,
  });

  // hint of input box
  final String label;

  // change function that called when value changed
  final Function(String)? changeFunction;

  //controller of GlobalInputBox
  final TextEditingController? controller;

  // GlobalInputBox is enabled
  final bool enable;

  // input type
  final TextInputType textType;

  // is GlobalInputBox read only or not
  final bool readOnly;

  // min lines of GlobalInputBox
  final int minLines;

  // max lines of GlobalInputBox
  final int? maxLines;

  // this GlobalInputBox most have value
  final bool mustFill;

  // validator of input box
  final Function? validator;

  // max length of input box
  final int? maxLength;

  // text direction of input box
  final TextDirection textDirection;

  final TextDirection hintDirection;

  // password mode
  final bool hideContent;

  final bool onlyEnglishLetters;

  final TextInputAction? textInputAction;

  final TextAlign textAlign;

  final FocusNode? currentFocusNode;
  final FocusNode? nextFocusNode;

  final String fontFamily;
  final double fontSize;

  final Widget? icon;

  final Color? backgroundColor;

  final double? height;
  @override
  GlobalInputBoxState createState() => GlobalInputBoxState();
}

class GlobalInputBoxState extends State<GlobalInputBox> {
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
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.minLines == 1 ? 40.h : widget.height,
      child: Card(
        // height:
        //     (widget.maxLines == null || widget.maxLines == 1) ? 45.h : null,
        // decoration: BoxDecoration(
        //   gradient: const LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [
        //       Colors.white24,
        //       Colors.white70,
        //     ],
        //   ),
        //   borderRadius: BorderRadius.circular(5),
        // ),
        elevation: 2,
        color: context.theme.colorScheme.scrim.withValues(alpha: .9),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: widget.controller,
                obscureText: widget.hideContent,
                focusNode: widget.currentFocusNode,
                enabled: widget.enable,
                readOnly: widget.readOnly,
                onChanged: widget.changeFunction,
                validator: (val) => validator!(val),
                maxLength: widget.maxLength,
                inputFormatters: widget.onlyEnglishLetters
                    ? [
                        FilteringTextInputFormatter.deny(
                          RegExp(r'[^\x00-\x7F]+'),
                        ),
                      ]
                    : [],
                decoration: InputDecoration(
                  counterText: "",
                  isDense: true,
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(10.0),
                  // ),
                  hintText: widget.label,
                  hintStyle: context.theme.textTheme.labelSmall!.copyWith(
                    fontSize: (widget.fontSize - 5).sp,
                    // height: 100,
                    // fontFamily: FontFamilies.titr,
                  ),
                  floatingLabelStyle: context.theme.textTheme.labelSmall!
                      .copyWith(
                        fontSize: (widget.fontSize - 1.5).sp,
                        // height: 100,
                        // fontFamily: FontFamilies.titr,
                      ),
                  contentPadding: EdgeInsets.only(
                    right: 5.w,
                    left: 5.w,
                    bottom: 10.h,
                    top: 10.h,
                  ),
                  // hintText: widget.label,
                  // hintTextDirection: widget.hintDirection,
                  // hintStyle: Get.textTheme.bodySmall!
                  //     .copyWith(color: Colors.grey[500]),
                  // suffixIcon: widget.icon,
                  // enabledBorder: InputBorder.none,
                  // focusedBorder: InputBorder.none,
                  // errorBorder: InputBorder.none,
                  // focusedErrorBorder: InputBorder.none,
                ),
                // cursorColor: widget.color,
                style: TextStyle(
                  color: context.theme.colorScheme.secondary,
                  fontSize: widget.fontSize.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: widget.fontFamily,
                  // height: 1.h,
                ),
                keyboardType: widget.textType,
                textInputAction: widget.textInputAction,
                minLines: widget.minLines,
                maxLines: widget.maxLines,
                textAlign: widget.textAlign,
                cursorColor: context.theme.colorScheme.secondary,
              ),
            ),
            if (widget.icon != null)
              Padding(
                padding: EdgeInsets.only(left: 1.w),
                child: widget.icon!,
              ),
          ],
        ),
      ),
    );
  }
}

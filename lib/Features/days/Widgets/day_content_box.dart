import 'package:flutter/material.dart';
import 'package:refreshed/refreshed.dart';
import 'package:miracle/Core/Resources/app_spacings.dart';

class DayContentBox extends StatefulWidget {
  const DayContentBox({
    Key? key,
    required this.content,
  }) : super(key: key);

  final String content;

  @override
  State<DayContentBox> createState() => _DayContentBoxState();
}

class _DayContentBoxState extends State<DayContentBox> {
  bool showContent = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacings.s10Horizental,
      width: double.maxFinite,
      child: InkWell(
        onTap: () {
          setState(() {
            showContent = !showContent;
          });
        },
        child: Card(
          child: Padding(
            padding: AppSpacings.s20All,
            child: Text(
              showContent ? widget.content : 'نمایش محتوا',
              textAlign: showContent ? TextAlign.right : TextAlign.center,
              textDirection: TextDirection.rtl,
              style: context.textTheme.displayLarge,
              maxLines: showContent ? null : 1,
            ),
          ),
        ),
      ),
    );
  }
}

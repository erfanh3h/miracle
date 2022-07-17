import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miracle/Core/Resources/app_colors.dart';

class GlobalReactionerWidget extends StatefulWidget {
  const GlobalReactionerWidget({
    Key? key,
    required this.initalValue,
  }) : super(key: key);

  final bool initalValue;

  @override
  State<GlobalReactionerWidget> createState() => _GlobalReactionerWidgetState();
}

class _GlobalReactionerWidgetState extends State<GlobalReactionerWidget> {
  late bool status;
  @override
  void initState() {
    status = widget.initalValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          status = !status;
        });
      },
      child: Icon(
        !status ? CupertinoIcons.heart : CupertinoIcons.heart_fill,
        color: AppColors.primary,
        size: 22.r,
      ),
    );
  }
}

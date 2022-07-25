import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:miracle/Core/Global/Controllers/global_controller.dart';
import 'package:miracle/Core/Global/Widgets/global_loading_widget.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:miracle/Core/Routes/app_routes.dart';
import 'package:miracle/Features/Review/Core/Review_repository.dart';

class GlobalReactionerWidget extends StatefulWidget {
  const GlobalReactionerWidget({
    Key? key,
    required this.initalValue,
    required this.reactionType,
    required this.reactionTypeId,
    this.onTapFunction,
  }) : super(key: key);

  final bool initalValue;
  final String reactionType;
  final int reactionTypeId;
  final VoidCallback? onTapFunction;

  @override
  State<GlobalReactionerWidget> createState() => _GlobalReactionerWidgetState();
}

class _GlobalReactionerWidgetState extends State<GlobalReactionerWidget> {
  late bool status;
  bool isLoading = false;
  @override
  void initState() {
    status = widget.initalValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (Get.find<GlobalController>().token.isEmpty) {
          Get.toNamed(AppRoutes.entry);
          return;
        }
        if (isLoading) {
          return;
        }
        setState(() {
          isLoading = true;
          status = !status;
        });
        final repo = Get.find<ReviewRepository>();
        if (status) {
          await repo.sendReaction(
            reactionType: widget.reactionType,
            reactionTypeId: widget.reactionTypeId,
          );
        } else {
          await repo.deleteReaction(
            reactionType: widget.reactionType,
            reactionTypeId: widget.reactionTypeId,
          );
        }
        if (widget.onTapFunction != null) {
          widget.onTapFunction!();
        }
        setState(() {
          isLoading = false;
        });
      },
      child: isLoading
          ? const GlobalLoadingWidget()
          : Icon(
              !status ? CupertinoIcons.heart : CupertinoIcons.heart_fill,
              color: AppColors.primary,
              size: 22.r,
            ),
    );
  }
}

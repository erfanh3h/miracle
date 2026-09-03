import 'package:flutter/material.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:toastification/toastification.dart';

class DialogCompanent {
  final String? message;
  final Color? color;
  final int? duration;

  DialogCompanent({this.message, this.color, this.duration});

  static void showToast({
    required String label,
    double? fontSize,
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    toastification.show(
      autoCloseDuration: const Duration(seconds: 3),
      alignment: Alignment.bottomCenter,
      direction: TextDirection.ltr,
      backgroundColor: Color(0xFF323232),
      showIcon: true,
      type: ToastificationType.info,
      primaryColor: AppColors.white,
      closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
      description: SizedBox(
        width: double.maxFinite,
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            label,
            style: TextStyle(fontFamily: "vazir", color: AppColors.white),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
        ),
      ),
    );
  }
}

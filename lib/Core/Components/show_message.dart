import 'package:flutter/material.dart';
import 'package:miracle/Core/Resources/app_colors.dart';
import 'package:overlay_support/overlay_support.dart';

class ShowMessageCompanent {
  final String? message;
  final Color? color;
  final int? duration;

  ShowMessageCompanent({this.message, this.color, this.duration});

  void show() {
    showSimpleNotification(
      Text(
        message ?? '',
        textDirection: TextDirection.rtl,
      ),
      background: color ?? AppColors.error,
      duration: Duration(seconds: duration ?? 3),
      position: NotificationPosition.bottom,
    );
  }
}

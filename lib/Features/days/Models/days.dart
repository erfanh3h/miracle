import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:hive/hive.dart';

part 'days.g.dart';

@HiveType(typeId: 1)
class DaysModel {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? content;
  @HiveField(3)
  final int dayNumber;
  @HiveField(4)
  final String? imageId;
  @HiveField(5)
  final List<String>? multiContents;
  @HiveField(6)
  final int? userId;
  @HiveField(7)
  final Uint8List? image;

  DaysModel({
    this.id,
    this.title,
    this.content,
    required this.dayNumber,
    this.imageId,
    this.multiContents,
    this.userId,
    this.image,
  });

  factory DaysModel.fromJson(Map data) {
    return DaysModel(
      id: data['id'],
      dayNumber: data['day_number'],
      title: data['title'],
      content: data['content'],
      userId: data['user_id'],
      imageId: data['image_id'],
      multiContents: data['multi_contents'],
    );
  }
  FormData toForm() {
    return FormData({
      'title': title,
      'content': content,
      'day_number': dayNumber,
    });
  }
}

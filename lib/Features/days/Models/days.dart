import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'days.g.dart';

@HiveType(typeId: 1)
class DaysModel {
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? content;
  @HiveField(3)
  final int dayNumber;
  @HiveField(4)
  final String? imageId;
  @HiveField(5)
  final List<dynamic>? multiContents;
  @HiveField(7)
  final Uint8List? image;
  @HiveField(8)
  final String? id;
  @HiveField(9)
  final String? userId;

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
      id: data['\$id'],
      dayNumber: data['day_number'],
      title: data['title'],
      content: data['content'],
      userId: data['user_id'],
      imageId: data['image_id'],
      multiContents: data['multi_contents'],
    );
  }
  Map toForm(final String userId) {
    Map result = {
      'title': title,
      'content': content,
      'day_number': dayNumber,
      'image_id': imageId,
      'user_id': userId,
      'multi_contents': multiContents,
    };
    return result;
  }

  DaysModel copyWith({
    final String? title,
    final int? dayNumber,
    final String? content,
    final String? imageId,
    final List<dynamic>? multiContents,
    final String? id,
    final String? userId,
  }) =>
      DaysModel(
        title: title ?? this.title,
        dayNumber: dayNumber ?? this.dayNumber,
        content: content ?? this.content,
        imageId: imageId ?? this.imageId,
        multiContents: multiContents ?? this.multiContents,
        id: id ?? this.id,
        userId: userId ?? this.userId,
      );
}

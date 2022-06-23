import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'days.g.dart';

@HiveType(typeId: 1)
class DaysModel {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? content;
  @HiveField(3)
  final int dayNumber;
  @HiveField(4)
  final String? imageUrl;
  @HiveField(5)
  final List<String>? multiContents;
  @HiveField(6)
  final String? userId;
  @HiveField(7)
  final Uint8List? image;

  DaysModel({
    this.id,
    this.title,
    this.content,
    required this.dayNumber,
    this.imageUrl,
    this.multiContents,
    this.userId,
    this.image,
  });
}

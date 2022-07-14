import 'package:get/get.dart';
import 'package:hive/hive.dart';

part 'review.g.dart';

@HiveType(typeId: 3)
class ReviewModel {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final int? reviewTypeId;
  @HiveField(2)
  final String? review;
  @HiveField(3)
  final String? reviewType;
  @HiveField(4)
  final int? parentId;
  @HiveField(5)
  final DateTime? createDate;
  @HiveField(6)
  final int? userId;
  @HiveField(7)
  final String? userName;
  @HiveField(8)
  final String? userImage;

  ReviewModel({
    this.id,
    this.reviewTypeId,
    this.review,
    this.reviewType,
    this.parentId,
    this.createDate,
    this.userId,
    this.userName,
    this.userImage,
  });

  factory ReviewModel.fromJson(Map data) {
    return ReviewModel(
      id: data['review']['id'],
      reviewTypeId: data['review']['review_type_id'],
      review: data['review']['review'],
      reviewType: data['review']['review_type'],
      parentId: data['review']['parent_id'],
      createDate: DateTime.parse(data['review']['create_date']),
      userId: data['author']['id'],
      userName: data['author']['username'],
      userImage: data['author']['image_id'],
    );
  }
  FormData toForm() {
    FormData result = FormData({
      'review_type_id': reviewTypeId,
      'review': review,
      'review_type': reviewType,
    });
    return result;
  }
}

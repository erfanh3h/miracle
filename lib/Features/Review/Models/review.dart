import 'package:hive/hive.dart';

part 'review.g.dart';

@HiveType(typeId: 3)
class ReviewModel {
  @HiveField(0)
  final String? userid;
  @HiveField(1)
  final int? username;
  @HiveField(2)
  final String? review;

  ReviewModel({
    this.userid,
    this.username,
    this.review,
  });

  factory ReviewModel.fromJson(Map data) {
    return ReviewModel();
  }
  Map toForm() {
    Map result = {
      'review': review,
      'author_id': userid,
    };
    return result;
  }
}

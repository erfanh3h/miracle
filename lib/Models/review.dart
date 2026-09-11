import 'package:hive_ce/hive.dart';

part 'review.g.dart';

@HiveType(typeId: 3)
class ReviewModel {
  @HiveField(0)
  final String? userid;
  @HiveField(1)
  final String? username;
  @HiveField(2)
  final String? userImage;
  @HiveField(3)
  final String content;
  @HiveField(4)
  final String targetType;
  @HiveField(5)
  final String targetId;
  @HiveField(6)
  final String? id;
  @HiveField(7)
  final DateTime? createdAt;

  ReviewModel({
    this.userid,
    this.username,
    required this.content,
    this.userImage,
    required this.targetId,
    required this.targetType,
    this.id,
    this.createdAt,
  });

  factory ReviewModel.fromJson(Map data) {
    return ReviewModel(
      id: data['\$id'],
      userid: data['author_id'],
      username: data['author_name'],
      content: data['content'],
      userImage: data['author_image'],
      targetId: data['target_id'],
      createdAt: DateTime.tryParse(data['\$createdAt']),
      targetType: data["target_type"],
    );
  }
  Map toForm() {
    Map result = {
      'content': content,
      'author_id': userid,
      'author_name': username,
      'author_image': userImage,
      'target_type': targetType,
      'target_id': targetId,
    };
    return result;
  }
}

import 'package:get/get.dart';
import 'package:hive/hive.dart';

part 'experience.g.dart';

@HiveType(typeId: 2)
class ExperienceModel {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String? content;
  @HiveField(3)
  final bool? isVoice;
  @HiveField(4)
  final String? fileId;
  @HiveField(5)
  final DateTime? createDate;
  @HiveField(6)
  final int? userId;
  @HiveField(7)
  final String? userName;
  @HiveField(8)
  final String? userImage;
  @HiveField(9)
  final bool? isLiked;
  @HiveField(10)
  final bool? letReview;
  @HiveField(11)
  final bool? isMyExperience;
  @HiveField(11)
  final bool? isAccepted;
  ExperienceModel({
    this.id,
    this.title,
    this.content,
    this.isVoice,
    this.fileId,
    this.createDate,
    this.userId,
    this.userName,
    this.userImage,
    this.isLiked,
    this.letReview,
    this.isMyExperience,
    this.isAccepted,
  });

  factory ExperienceModel.fromJson(Map data, {bool? isMyExperience}) {
    return ExperienceModel(
      id: data['experience']['id'],
      isVoice: data['experience']['is_voice'],
      title: data['experience']['title'],
      content: data['experience']['content'],
      userId: data['experience']['author_id'],
      fileId: data['experience']['file_id'],
      isLiked: data['is_liked'],
      createDate: DateTime.parse(data['experience']['create_date']),
      userName: data['author']['username'],
      userImage: data['author']['image_id'],
      letReview: data['experience']['let_review'],
      isMyExperience: isMyExperience ?? false,
      isAccepted: data['experience']['is_accepted'],
    );
  }
  FormData toForm() {
    FormData result = FormData({
      'title': title,
      'content': content,
      'is_voice': isVoice,
      'file_id': fileId,
      'let_review': letReview,
    });
    return result;
  }
}

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
  @HiveField(12)
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
  Map toForm() {
    Map result = {
      'title': title,
      'content': content,
      'is_voice': isVoice,
      'file_id': fileId,
      'let_review': letReview,
    };
    return result;
  }

  ExperienceModel copyWith({
    final int? id,
    final String? title,
    final String? content,
    final bool? isVoice,
    final String? fileId,
    final DateTime? createDate,
    final int? userId,
    final String? userName,
    final String? userImage,
    final bool? isLiked,
    final bool? letReview,
    final bool? isMyExperience,
    final bool? isAccepted,
  }) =>
      ExperienceModel(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        isVoice: isVoice ?? this.isVoice,
        fileId: fileId ?? this.fileId,
        createDate: createDate ?? this.createDate,
        userId: userId ?? this.userId,
        userName: userName ?? this.userName,
        userImage: userImage ?? this.userImage,
        isLiked: isLiked ?? this.isLiked,
        letReview: letReview ?? this.letReview,
        isMyExperience: isMyExperience ?? this.isMyExperience,
        isAccepted: isAccepted ?? this.isAccepted,
      );
}

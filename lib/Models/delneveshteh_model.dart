import 'package:hive_ce/hive.dart';

part 'delneveshteh_model.g.dart';

@HiveType(typeId: 4)
class DelneveshtehModel {
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String content;
  @HiveField(3)
  final int categoryId;
  @HiveField(4)
  final String? fileId;
  @HiveField(5)
  final DateTime createdAt;
  @HiveField(6)
  final bool letReview;
  @HiveField(7)
  final String? id;
  @HiveField(8)
  final String authorId;
  @HiveField(9)
  final String? authorImage;
  @HiveField(10)
  final String authorName;

  DelneveshtehModel({
    this.id,
    required this.title,
    required this.content,
    required this.categoryId,
    this.fileId,
    required this.createdAt,
    required this.authorId,
    required this.letReview,
    this.authorImage,
    required this.authorName,
  });

  factory DelneveshtehModel.fromJson(Map data) {
    return DelneveshtehModel(
      id: data['\$id'],
      categoryId: data['category_id'],
      title: data['title'],
      content: data['content'],
      authorId: data['author_id'],
      fileId: data['letReview_id'],
      createdAt: data['\$createdAt'],
      letReview: data["let_review"],
      authorImage: data["author_image"],
      authorName: data["author_name"],
    );
  }
  Map toJson() {
    Map result = {
      'title': title,
      'content': content,
      'category_id': categoryId,
      'let_review': letReview,
      'author_id': authorId,
      'author_image': authorImage,
      'author_name': authorName,
      'file_id': fileId,
    };
    return result;
  }

  DelneveshtehModel copyWith({
    String? title,
    int? categoryId,
    String? content,
    String? fileId,
    DateTime? createdAt,
    String? id,
    String? authorId,
    String? authorName,
    String? authorImage,
    bool? letReview,
  }) => DelneveshtehModel(
    title: title ?? this.title,
    categoryId: categoryId ?? this.categoryId,
    content: content ?? this.content,
    fileId: fileId ?? this.fileId,
    createdAt: createdAt ?? this.createdAt,
    id: id ?? this.id,
    authorId: authorId ?? this.authorId,
    letReview: letReview ?? this.letReview,
    authorName: authorName ?? this.authorName,
    authorImage: authorImage ?? this.authorImage,
  );
}

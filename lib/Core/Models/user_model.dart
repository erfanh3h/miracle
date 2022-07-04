import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? username;
  @HiveField(2)
  final String? imageId;
  @HiveField(3)
  final String? token;
  @HiveField(4)
  final DateTime? createDate;
  @HiveField(5)
  final bool? letSendPost;
  @HiveField(6)
  final bool? saveDayDatas;
  @HiveField(7)
  final String? phone;

  UserModel({
    this.id,
    this.username,
    this.imageId,
    this.token,
    this.createDate,
    this.letSendPost,
    this.saveDayDatas,
    this.phone,
  });

  factory UserModel.fromJson(Map data, String token) {
    return UserModel(
      id: data['id'],
      username: data['user_name'],
      imageId: data['image_id'],
      token: token,
      createDate:DateTime.parse(data['create_date']) ,
      letSendPost: data['let_send_post'],
      saveDayDatas: data['save_day_data'],
      phone: data['phone'].toString(),
    );
  }
}

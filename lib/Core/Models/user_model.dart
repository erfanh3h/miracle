import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String? token;
  @HiveField(1)
  final String? email;
  @HiveField(2)
  final String? avatar;
  @HiveField(3)
  final String? name;
  @HiveField(4)
  final DateTime? expiry;

  UserModel({
    this.token,
    this.email,
    this.avatar,
    this.name,
    this.expiry,
  });

  factory UserModel.fromJson(Map data) {
    return UserModel(
      token: data[''],
      email: data[''],
      avatar: data[''],
      name: data[''],
      expiry: data[''],
    );
  }
}

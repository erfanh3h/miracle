import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? name;
  @HiveField(7)
  final String? email;

  UserModel({
    this.id,
    this.name,
    this.email,
  });

  factory UserModel.fromJson(Map data, String token) {
    return UserModel(
      id: data['id'],
      name: data['user_name'],
      email: data['email'].toString(),
    );
  }
}

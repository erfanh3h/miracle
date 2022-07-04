// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as int?,
      username: fields[1] as String?,
      imageId: fields[2] as String?,
      token: fields[3] as String?,
      createDate: fields[4] as DateTime?,
      letSendPost: fields[5] as bool?,
      saveDayDatas: fields[6] as bool?,
      phone: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.imageId)
      ..writeByte(3)
      ..write(obj.token)
      ..writeByte(4)
      ..write(obj.createDate)
      ..writeByte(5)
      ..write(obj.letSendPost)
      ..writeByte(6)
      ..write(obj.saveDayDatas)
      ..writeByte(7)
      ..write(obj.phone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

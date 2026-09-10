// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReviewModelAdapter extends TypeAdapter<ReviewModel> {
  @override
  final typeId = 3;

  @override
  ReviewModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReviewModel(
      userid: fields[0] as String,
      username: fields[1] as String,
      content: fields[3] as String,
      userImage: fields[2] as String?,
      targetId: fields[5] as String,
      targetType: fields[4] as String,
      id: fields[6] as String?,
      createdAt: fields[7] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, ReviewModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.userid)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.userImage)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.targetType)
      ..writeByte(5)
      ..write(obj.targetId)
      ..writeByte(6)
      ..write(obj.id)
      ..writeByte(7)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

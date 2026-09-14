// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delneveshteh_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DelneveshtehModelAdapter extends TypeAdapter<DelneveshtehModel> {
  @override
  final typeId = 4;

  @override
  DelneveshtehModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DelneveshtehModel(
      id: fields[7] as String?,
      title: fields[1] as String,
      content: fields[2] as String,
      categoryId: fields[3] as String,
      fileId: fields[4] as String?,
      createdAt: fields[5] as DateTime?,
      authorId: fields[8] as String,
      confirmed: fields[6] as bool,
      authorImage: fields[9] as String?,
      authorName: fields[10] as String,
      reviewCount: (fields[11] as num?)?.toInt(),
      likeCount: (fields[12] as num?)?.toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, DelneveshtehModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.categoryId)
      ..writeByte(4)
      ..write(obj.fileId)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.confirmed)
      ..writeByte(7)
      ..write(obj.id)
      ..writeByte(8)
      ..write(obj.authorId)
      ..writeByte(9)
      ..write(obj.authorImage)
      ..writeByte(10)
      ..write(obj.authorName)
      ..writeByte(11)
      ..write(obj.reviewCount)
      ..writeByte(12)
      ..write(obj.likeCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DelneveshtehModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

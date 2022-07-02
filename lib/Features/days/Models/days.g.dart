// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'days.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DaysModelAdapter extends TypeAdapter<DaysModel> {
  @override
  final int typeId = 1;

  @override
  DaysModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DaysModel(
      id: fields[0] as int?,
      title: fields[1] as String?,
      content: fields[2] as String?,
      dayNumber: fields[3] as int,
      imageId: fields[4] as String?,
      multiContents: (fields[5] as List?)?.cast<dynamic>(),
      userId: fields[6] as int?,
      image: fields[7] as Uint8List?,
    );
  }

  @override
  void write(BinaryWriter writer, DaysModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.dayNumber)
      ..writeByte(4)
      ..write(obj.imageId)
      ..writeByte(5)
      ..write(obj.multiContents)
      ..writeByte(6)
      ..write(obj.userId)
      ..writeByte(7)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DaysModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

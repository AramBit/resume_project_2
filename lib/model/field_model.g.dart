// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FieldModelAdapter extends TypeAdapter<FieldModel> {
  @override
  final int typeId = 0;

  @override
  FieldModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FieldModel(
      image: fields[0] as String?,
      courtName: fields[1] as String,
      adress: fields[2] as String,
      description: fields[3] as String?,
      distance: fields[4] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, FieldModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.courtName)
      ..writeByte(2)
      ..write(obj.adress)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.distance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FieldModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

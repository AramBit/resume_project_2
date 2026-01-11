// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_result_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameResultModelAdapter extends TypeAdapter<GameResultModel> {
  @override
  final int typeId = 1;

  @override
  GameResultModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameResultModel(
      image: fields[0] as String?,
      courtName: fields[1] as String,
      adress: fields[2] as String,
      description: fields[3] as String,
      players: (fields[4] as List).cast<Player>(),
      timer: fields[5] as String,
      gameMode: fields[6] as int,
      date: fields[7] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, GameResultModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.courtName)
      ..writeByte(2)
      ..write(obj.adress)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.players)
      ..writeByte(5)
      ..write(obj.timer)
      ..writeByte(6)
      ..write(obj.gameMode)
      ..writeByte(7)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameResultModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlayerAdapter extends TypeAdapter<Player> {
  @override
  final int typeId = 2;

  @override
  Player read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Player(
      name: fields[0] as String?,
      score: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Player obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.score);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

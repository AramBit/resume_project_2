import 'package:hive/hive.dart';

part 'game_result_model.g.dart';

@HiveType(typeId: 1)
class GameResultModel extends HiveObject {
  @HiveField(0)
  String? image;

  @HiveField(1)
  String courtName;

  @HiveField(2)
  String adress;

  @HiveField(3)
  String description;

  @HiveField(4)
  List<Player> players;

  @HiveField(5)
  String timer;

  @HiveField(6)
  int gameMode;

  @HiveField(7)
  DateTime date;

  GameResultModel({
    required this.image,
    required this.courtName,
    required this.adress,
    required this.description,
    required this.players,
    required this.timer,
    required this.gameMode,
    required this.date,
  });
}

@HiveType(typeId: 2)
class Player extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String score;

  Player({
    required this.name,
    required this.score,
  });
}

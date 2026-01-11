import 'package:hive/hive.dart';

part 'field_model.g.dart';

@HiveType(typeId: 0)
class FieldModel extends HiveObject {
  @HiveField(0)
  String? image;

  @HiveField(1)
  String courtName;
  @HiveField(2)
  String adress;
  @HiveField(3)
  String? description;
  @HiveField(4)
  double? distance;

  FieldModel({
    required this.image,
    required this.courtName,
    required this.adress,
    required this.description,
    required this.distance,
  });
}

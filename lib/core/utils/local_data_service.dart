import 'package:hive_flutter/hive_flutter.dart';

class LocalDataService {
  static Box? localData;
  static Future<void> initLocalDataService() async {
    localData = await Hive.openBox('myBox');
  }
}

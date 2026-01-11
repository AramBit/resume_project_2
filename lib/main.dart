import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/utils/local_data_service.dart';
import 'dependencies.dart';
import 'model/field_model.dart';
import 'model/game_result_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(FieldModelAdapter());
  Hive.registerAdapter(PlayerAdapter());
  Hive.registerAdapter(GameResultModelAdapter());
  await LocalDataService.initLocalDataService();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const AppGameDependencies());
}

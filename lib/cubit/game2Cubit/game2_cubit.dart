import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/utils/local_data_service.dart';
import '../../model/game_result_model.dart';
import '../../screens/theme/app_texts.dart';
import 'game2_state.dart';

class Game2Cubit extends Cubit<Game2State> {
  Game2Cubit()
      : super(
          Game2State(),
        );
  void getGameData() {
    emit(
      state.copyWith(
        copygameResult: LocalDataService.localData!.get('gameResult'),
      ),
    );
  }

  void initGameMode() {
    emit(
      state.copyWith(
        copygameMode: getGameMode(state.gameResult!.gameMode),
      ),
    );
  }

  static Future<void> captureAndShare() async {
    Uint8List? image = await Game2State.screenshotController.capture();
    if (image == null) return;
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/screenshot.png';
    File(filePath).writeAsBytesSync(image);
    await Share.shareXFiles(
      [XFile(filePath)],
      text: 'Смотри, что я нашёл!',
    );
  }

  static String formatDateTime(DateTime dateTime) {
    final dateFormatter = DateFormat('d MMM, yyyy • HH:mm');
    return dateFormatter.format(dateTime);
  }

  static String getGameMode(int type) {
    switch (type) {
      case 1:
        return AppTexts.cLASSICMODELower;
      case 2:
        return AppTexts.aNVANCEDMODELower;
      case 3:
        return AppTexts.paybackModeLower;
    }
    return AppTexts.cLASSICMODELower;
  }

  static bool isScoreHighestAmongPlayers(List<Player> players, String scoreToCheck) {
    final sentScore = int.tryParse(scoreToCheck) ?? 0;

    for (final player in players) {
      final playerScore = int.tryParse(player.score) ?? 0;

      if (player.score == scoreToCheck) continue;

      if (sentScore <= playerScore) {
        return false;
      }
    }
    return true;
  }

  void clearData() {
    emit(
      state.copyWith(
        removeGameResult: true,
        copygameMode: '',
      ),
    );
  }
}

import 'package:screenshot/screenshot.dart';

import '../../model/game_result_model.dart';

class Game2State {
  Game2State({
    this.gameResult,
    this.gameMode = '',
  });
  final GameResultModel? gameResult;
  final String gameMode;
  static final ScreenshotController screenshotController = ScreenshotController();

  Game2State copyWith({
    GameResultModel? copygameResult,
    bool removeGameResult = false,
    String? copygameMode,
  }) {
    return Game2State(
      gameResult: removeGameResult ? null : copygameResult ?? gameResult,
      gameMode: copygameMode ?? gameMode,
    );
  }
}

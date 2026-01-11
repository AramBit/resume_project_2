import 'dart:async';

import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class GameState {
  GameState({
    this.gameParameters,
    this.playersBox = const [],
    this.numberOfPlayers = const [],
    this.second = 0,
  });
  final Map<String, dynamic>? gameParameters;
  final List<Widget> playersBox;
  final List<int> numberOfPlayers;
  int second;
  static Timer? timer;
  static final ScreenshotController screenshotController = ScreenshotController();
  GameState copyWith({
    Map<String, dynamic>? copygameParameters,
    bool removeGameParameters = false,
    List<Widget>? copyplayersBox,
    List<int>? copynumberOfPlayers,
    int? copysecond,
  }) {
    return GameState(
      gameParameters: removeGameParameters ? null : copygameParameters ?? gameParameters,
      playersBox: copyplayersBox ?? playersBox,
      numberOfPlayers: copynumberOfPlayers ?? numberOfPlayers,
      second: copysecond ?? second,
    );
  }
}

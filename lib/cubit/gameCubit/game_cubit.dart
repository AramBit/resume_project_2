import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:app_b_839/core/utils/local_data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../model/game_result_model.dart';
import '../../screens/game/widgets/game_player.dart';
import 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit()
      : super(
          GameState(),
        );
  void saveData() {
    List<Player> playersResult = [];
    for (int i = 0; i < (state.gameParameters!['players'] as List<String>).length; i++) {
      playersResult.add(
        Player(
          name: state.gameParameters!['players'][i],
          score: state.numberOfPlayers[i].toString(),
        ),
      );
    }
    LocalDataService.localData!.put(
      'gameResult',
      GameResultModel(
        timer: state.gameParameters!['timer'] ? timerText() : '',
        image: state.gameParameters!['image'],
        players: playersResult,
        courtName: state.gameParameters!['name'],
        adress: state.gameParameters!['adress'],
        description: state.gameParameters!['description'],
        gameMode: state.gameParameters!['gameMode'],
        date: DateTime.now(),
      ),
    );
    clearData();
  }

  static Future<void> captureAndShare() async {
    Uint8List? image = await GameState.screenshotController.capture();
    if (image == null) return;
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/screenshot.png';
    File(filePath).writeAsBytesSync(image);
    await Share.shareXFiles(
      [XFile(filePath)],
      text: 'Смотри, что я нашёл!',
    );
  }

  void startTimer() {
    if (state.gameParameters == null) return;
    if (state.gameParameters!['timer'] == false) return;

    GameState.timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      emit(
        state.copyWith(
          copysecond: state.second += 1,
        ),
      );
    });
  }

  String timerText() {
    final minutes = (state.second ~/ 60).toString().padLeft(2, '0');
    final seconds = (state.second % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  void playersIncrement(int index) {
    state.numberOfPlayers[index] = state.numberOfPlayers[index] + 10;

    emit(
      state.copyWith(
        copynumberOfPlayers: state.numberOfPlayers,
      ),
    );
    changListPlayers();
  }

  void playersIncrementLongPress(int index) {
    state.numberOfPlayers[index] = state.numberOfPlayers[index] + 100;

    emit(
      state.copyWith(
        copynumberOfPlayers: state.numberOfPlayers,
      ),
    );
    changListPlayers();
  }

  void playersDecrement(int index) {
    if (state.numberOfPlayers[index] <= 0) return;
    state.numberOfPlayers[index] = state.numberOfPlayers[index] - 10;
    emit(
      state.copyWith(
        copynumberOfPlayers: state.numberOfPlayers,
      ),
    );
    changListPlayers();
  }

  void addValueForPlayer() {
    List<int> result = [];
    for (int e in state.numberOfPlayers) {
      result.add(e);
    }
    result.add(
      0,
    );
    emit(
      state.copyWith(
        copynumberOfPlayers: result,
      ),
    );
  }

  void changListPlayers() {
    Map<String, dynamic> result = (LocalDataService.localData!.get('gameParameters') as Map).cast();
    List<Widget> playerBoxResult = [];

    for (int i = 0; i < state.playersBox.length; i++) {
      playerBoxResult.add(
        GamePlayer(
          decrementBorder: '0',
          onTapDecrementLognPress: () {
            playersDecrement(i);
          },
          onTapIncrementLognPress: () {
            playersIncrementLongPress(i);
          },
          name: result['players'][i],
          onTapDecrement: () {
            playersDecrement(i);
          },
          onTapIncrement: () {
            playersIncrement(i);
          },
          number: (i + 1).toString(),
          value: state.numberOfPlayers[i].toString(),
        ),
      );
    }
    emit(
      state.copyWith(
        copyplayersBox: playerBoxResult,
      ),
    );
  }

  List<Widget> getGameParameters() {
    Map<String, dynamic> result = (LocalDataService.localData!.get('gameParameters') as Map).cast();
    List<Widget> playerBoxResult = [];

    for (int i = 0; i < (result['players'] as List).length; i++) {
      addValueForPlayer();

      playerBoxResult.add(
        GamePlayer(
          decrementBorder: '0',
          name: result['players'][i],
          onTapDecrement: () {
            playersDecrement(i);
          },
          onTapIncrement: () {
            playersIncrement(i);
          },
          onTapDecrementLognPress: () {
            playersDecrement(i);
          },
          onTapIncrementLognPress: () {
            playersIncrementLongPress(i);
          },
          number: (i + 1).toString(),
          value: state.numberOfPlayers[i].toString(),
        ),
      );
    }
    emit(
      state.copyWith(
        copygameParameters: result,
        copyplayersBox: playerBoxResult,
        copynumberOfPlayers: state.numberOfPlayers,
      ),
    );
    return playerBoxResult;
  }

  void clearData() {
    emit(
      state.copyWith(
        removeGameParameters: true,
        copynumberOfPlayers: [],
        copyplayersBox: [],
        copysecond: 0,
      ),
    );
  }
}

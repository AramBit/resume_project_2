import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/local_data_service.dart';
import '../../model/field_model.dart';
import '../../screens/theme/app_texts.dart';
import '../addFieldCubit/add_field_cubit.dart';
import 'new_game_state.dart';

class NewGameCubit extends Cubit<NewGameState> {
  static NewGameCubit? newGameCubit;
  NewGameCubit()
      : super(
          NewGameState(),
        ) {
    initFirstPlayers();
  }
  void save() {
    LocalDataService.localData!.put('gameParameters', {
      'players': state.players,
      'timer': state.timerIsSelect,
      'gameMode': state.gameMode,
      'field': state.chosenFieldId,
      'image': state.fields[state.chosenFieldId!].image,
      'name': state.fields[state.chosenFieldId!].courtName,
      'adress': state.fields[state.chosenFieldId!].adress,
      'description': state.fields[state.chosenFieldId!].description,
    });
  }

  void choseField(int index) {
    emit(
      state.copyWith(
        copychosenFieldIde: index,
      ),
    );
  }

  void clearData() {
    emit(
      state.copyWith(
        copynumberOfPlayers: 3,
        removeChosenFieldIde: true,
        copyfields: [],
        copygameMode: 1,
        copytimerIsSelect: false,
        removeChosenId: true,
      ),
    );
  }

  void choseClassicMode(int index) {
    emit(
      state.copyWith(
        copygameMode: index,
      ),
    );
  }

  void choseTimer() {
    emit(
      state.copyWith(
        copytimerIsSelect: !state.timerIsSelect,
      ),
    );
  }

  void changePlayer(int index) {
    List<String> playerResult = getMutablePlayers();
    String? player = getRandomPlayerName(playerResult);
    if (player == null) return;
    playerResult[index] = player;
    emit(
      state.copyWith(
        copyplayers: playerResult,
      ),
    );
  }

  void initFirstPlayers() {
    List<String> result = [];
    result.add(
      LocalDataService.localData!.get(
            'userName',
          ) ??
          'Strauss Zelnick',
    );
    for (int i = 0; i < 2; i++) {
      result.add(
        getRandomPlayerName(state.players)!,
      );
    }
    emit(
      state.copyWith(
        copyplayers: result,
      ),
    );
  }

  String? getRandomPlayerName(List<String> selectedPlayers) {
    final random = Random();

    final availablePlayers =
        AppTexts.listNameOfPlayers.where((name) => !selectedPlayers.contains(name)).toList();

    if (availablePlayers.isEmpty) return null;

    return availablePlayers[random.nextInt(availablePlayers.length)];
  }

  void playersIncrement() {
    if (state.numberOfPlayers >= 6) return;
    addNewPlayer();
    emit(
      state.copyWith(
        copynumberOfPlayers: state.numberOfPlayers + 1,
      ),
    );
  }

  void playersDecrement() {
    if (state.numberOfPlayers <= 3) return;
    removePlayer();
    emit(
      state.copyWith(
        copynumberOfPlayers: state.numberOfPlayers - 1,
      ),
    );
  }

  void getFields() {
    List<FieldModel> result = AddFieldCubit.getFieldAsAnList();
    emit(
      state.copyWith(
        copyfields: result,
      ),
    );
  }

  List<String> getMutablePlayers() {
    List<String> result = [];
    for (String e in state.players) {
      result.add(e);
    }
    return result;
  }

  void removePlayer() {
    List<String> result = getMutablePlayers();
    result.removeLast();
    emit(
      state.copyWith(
        copyplayers: result,
      ),
    );
  }

  void addNewPlayer() {
    List<String> result = getMutablePlayers();
    String? player = getRandomPlayerName(state.players);
    if (player == null) return;

    result.add(
      player,
    );
    emit(
      state.copyWith(
        copyplayers: result,
      ),
    );
  }
}

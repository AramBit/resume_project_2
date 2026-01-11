import 'package:app_b_839/model/field_model.dart';
import 'package:flutter/material.dart';

class NewGameState {
  NewGameState({
    this.numberOfPlayers = 3,
    this.players = const [],
    this.gameMode = 1,
    this.timerIsSelect = false,
    this.fields = const [],
    this.chosenFieldId,
  });
  List<Widget> pages = [];
  final int numberOfPlayers;
  final List<String> players;
  final List<FieldModel> fields;
  final int gameMode;
  final bool timerIsSelect;
  final int? chosenFieldId;
  NewGameState copyWith({
    int? copynumberOfPlayers,
    List<String>? copyplayers,
    int? copygameMode,
    bool? copytimerIsSelect,
    List<FieldModel>? copyfields,
    int? copychosenFieldIde,
    bool removeChosenFieldIde = false,
    bool removeChosenId = false,
  }) {
    return NewGameState(
      numberOfPlayers: copynumberOfPlayers ?? numberOfPlayers,
      players: copyplayers ?? players,
      gameMode: copygameMode ?? gameMode,
      timerIsSelect: copytimerIsSelect ?? timerIsSelect,
      fields: copyfields ?? fields,
      chosenFieldId: removeChosenId
          ? null
          : removeChosenFieldIde
              ? null
              : copychosenFieldIde ?? chosenFieldId,
    );
  }
}

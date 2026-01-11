import 'package:flutter/material.dart';

import '../../../cubit/newGameCubit/new_game_cubit.dart';
import '../../../cubit/newGameCubit/new_game_state.dart';
import '../../globalWidgets/game_mode_dialog.dart';
import '../../theme/app_texts.dart';
import 'game_mode_card.dart';

class GameMode extends StatelessWidget {
  const GameMode({
    super.key,
    required this.state,
  });
  final NewGameState state;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          8,
        ),
      ),
      child: Column(
        children: [
          GameModeCard(
            isSelect: state.gameMode == 1 ? true : false,
            infoOnTap: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) => GameModeDialog(
                  title: AppTexts.cLASSICMODE,
                  text: AppTexts.clasicModeDescr,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              );
            },
            selectOnTap: () {
              NewGameCubit.newGameCubit!.choseClassicMode(1);
            },
            name: AppTexts.cLASSICMODELower,
            description: 'Throw, run - catch.',
            number: 'C',
          ),
          GameModeCard(
            isSelect: state.gameMode == 2 ? true : false,
            infoOnTap: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) => GameModeDialog(
                  title: AppTexts.aNVANCEDMODE,
                  text: AppTexts.descriptionAdvanced,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              );
            },
            selectOnTap: () {
              NewGameCubit.newGameCubit!.choseClassicMode(2);
            },
            name: AppTexts.aNVANCEDMODELower,
            description: 'Throw, run, catch, just like before.',
            number: 'A',
          ),
          GameModeCard(
            isSelect: state.gameMode == 3 ? true : false,
            infoOnTap: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) => GameModeDialog(
                  title: AppTexts.pAYBACKMODE,
                  text: AppTexts.descriptionPenaltyMode,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              );
            },
            selectOnTap: () {
              NewGameCubit.newGameCubit!.choseClassicMode(3);
            },
            name: AppTexts.paybackModeLower,
            description: 'Throw, run, catch,  with fouls.',
            number: 'P',
          ),
        ],
      ),
    );
  }
}

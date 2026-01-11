import 'package:app_b_839/screens/globalWidgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/routes/app_routes.dart';
import '../../core/utils/navigator_service.dart';
import '../../core/utils/size_utils.dart';
import '../../cubit/newGameCubit/new_game_cubit.dart';
import '../../cubit/newGameCubit/new_game_state.dart';
import '../../gen/assets.gen.dart';
import '../globalWidgets/custom_appbar.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_texts.dart';
import 'widget/game_mode.dart';
import 'widget/game_mode_card.dart';
import 'widget/players_box.dart';

class NewGame extends StatelessWidget {
  const NewGame({super.key});

  @override
  Widget build(BuildContext context) {
    NewGameCubit.newGameCubit = context.watch<NewGameCubit>();
    return BlocBuilder<NewGameCubit, NewGameState>(
      bloc: NewGameCubit.newGameCubit,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backgroundOne,
          body: Stack(
            children: [
              Column(
                children: [
                  CustomAppBar(
                    text: AppTexts.nEWGAME,
                    backOnTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(
                              20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  AppTexts.youCanCreateANewGameIn,
                                  style: AppTextStyles.news16.copyWith(
                                    color: AppColors.layerThree,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  AppTexts.players.toUpperCase(),
                                  style: AppTextStyles.bold12.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                PlayersBox(
                                  incrementOnTap: () {
                                    NewGameCubit.newGameCubit!.playersIncrement();
                                  },
                                  decrementOnTap: () {
                                    NewGameCubit.newGameCubit!.playersDecrement();
                                  },
                                  playerCount: state.numberOfPlayers.toString(),
                                  players: state.players,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  AppTexts.gameMode.toUpperCase(),
                                  style: AppTextStyles.bold12.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                GameMode(
                                  state: state,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      8,
                                    ),
                                  ),
                                  child: GameModeCard(
                                    timerIcon: Assets.images.timer.path,
                                    selectOnTap: () {
                                      NewGameCubit.newGameCubit!.choseTimer();
                                    },
                                    name: AppTexts.gameTimer,
                                    description: 'Monitor game time using the Timer.',
                                    number: 'C',
                                    isSelect: state.timerIsSelect,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: ResponsiveExtension.screenHeight / 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: ResponsiveExtension.screenHeight / 7,
                  color: Colors.white,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: MainButton(
                        text: AppTexts.cONTINUE,
                        onTap: () {
                          NavigatorService.pushNamedAndRemoveUntil(
                            context: context,
                            AppRoutes.newGame2,
                            removeCurrentPage: true,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              // const EmpthyFieldsWidget(),
            ],
          ),
        );
      },
    );
  }
}

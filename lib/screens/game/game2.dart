import 'package:app_b_839/screens/globalWidgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenshot/screenshot.dart';

import '../../core/routes/app_routes.dart';
import '../../core/utils/navigator_service.dart';
import '../../core/utils/size_utils.dart';
import '../../cubit/game2Cubit/game2_cubit.dart';
import '../../cubit/game2Cubit/game2_state.dart';
import '../../gen/assets.gen.dart';
import '../globalWidgets/custom_appbar.dart';
import '../globalWidgets/custom_image_view.dart';
import '../globalWidgets/field_widget.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_texts.dart';
import 'widgets/game2_players_card.dart';
import 'widgets/timer_widget.dart';

class Game2 extends StatefulWidget {
  const Game2({super.key});

  @override
  State<Game2> createState() => _Game2State();
}

class _Game2State extends State<Game2> {
  Game2Cubit? game2cubit;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        game2cubit!.getGameData();

        game2cubit!.initGameMode();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    game2cubit = context.watch<Game2Cubit>();
    return BlocBuilder<Game2Cubit, Game2State>(
        bloc: game2cubit,
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Scaffold(
              backgroundColor: AppColors.backgroundOne,
              body: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomAppBar(
                        text: AppTexts.gAME,
                        rightWidget: GestureDetector(
                          onTap: () {
                            Game2Cubit.captureAndShare();
                          },
                          child: CustomImageView(
                            imagePath: Assets.images.share.path,
                            width: ResponsiveExtension.screenWidth / 15,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Screenshot(
                          controller: Game2State.screenshotController,
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
                                        height: 10,
                                      ),
                                      Text(
                                        AppTexts.playersBOARD.toUpperCase(),
                                        style: AppTextStyles.bold12.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Column(
                                          children: List.generate(
                                              state.gameResult == null
                                                  ? 0
                                                  : state.gameResult!.players.length, (index) {
                                            return Game2PlayerCard(
                                              name: state.gameResult!.players[index].name!,
                                              number: (index + 1).toString(),
                                              score: state.gameResult!.players[index].score,
                                              scoreColor: Game2Cubit.isScoreHighestAmongPlayers(
                                                state.gameResult!.players,
                                                state.gameResult!.players[index].score,
                                              )
                                                  ? AppColors.accentOne
                                                  : AppColors.layerOne,
                                            );
                                          }),
                                        ),
                                      ),
                                      if (state.gameResult != null)
                                        if (state.gameResult!.image != null)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 10,
                                              top: 10,
                                            ),
                                            child: FieldWidget(
                                              field: state.gameResult!.image,
                                              onTap: () {},
                                              courtName: state.gameResult!.courtName,
                                              distance: '1,200',
                                            ),
                                          ),
                                      if (state.gameResult != null)
                                        if (state.gameResult!.timer.isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 10,
                                            ),
                                            child: TimerWidget(
                                              value: state.gameResult!.timer,
                                            ),
                                          ),
                                      if (state.gameResult != null)
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 20,
                                            ),
                                            child: Text(
                                              '${state.gameMode} | ${Game2Cubit.formatDateTime(state.gameResult!.date)}',
                                              style: AppTextStyles.bold16.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.layerThree,
                                              ),
                                            ),
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
                            text: AppTexts.gOTOMAIN,
                            onTap: () {
                              game2cubit!.clearData();
                              NavigatorService.pushNamedAndRemoveUntil(
                                context: context,
                                AppRoutes.homePage,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

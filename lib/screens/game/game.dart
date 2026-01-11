import 'package:app_b_839/screens/globalWidgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenshot/screenshot.dart';

import '../../core/routes/app_routes.dart';
import '../../core/utils/navigator_service.dart';
import '../../core/utils/size_utils.dart';
import '../../cubit/gameCubit/game_cubit.dart';
import '../../cubit/gameCubit/game_state.dart';
import '../../gen/assets.gen.dart';
import '../globalWidgets/custom_appbar.dart';
import '../globalWidgets/custom_cup_dialog.dart';
import '../globalWidgets/custom_image_view.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_texts.dart';
import 'widgets/timer_widget.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  GameCubit? gameCubit;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        gameCubit!.getGameParameters();

        gameCubit!.startTimer();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    gameCubit = context.watch<GameCubit>();
    return BlocBuilder<GameCubit, GameState>(
        bloc: gameCubit,
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
                    children: [
                      CustomAppBar(
                        text: AppTexts.gAME,
                        rightWidget: GestureDetector(
                          onTap: () {
                            GameCubit.captureAndShare();
                          },
                          child: CustomImageView(
                            imagePath: Assets.images.share.path,
                            width: ResponsiveExtension.screenWidth / 15,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Screenshot(
                          controller: GameState.screenshotController,
                          child: SingleChildScrollView(
                            child: Padding(
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
                                    AppTexts.theNameGoalIs,
                                    style: AppTextStyles.news16.copyWith(
                                      color: AppColors.layerThree,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
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
                                      children: state.playersBox,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  if (state.gameParameters != null)
                                    if (state.gameParameters!['timer'])
                                      TimerWidget(
                                        value: gameCubit!.timerText(),
                                      ),
                                  SizedBox(
                                    height: ResponsiveExtension.screenHeight / 5,
                                  ),
                                ],
                              ),
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
                            text: AppTexts.fINISHGAME,
                            onTap: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (_) => CustomAlertDialog(
                                  title: AppTexts.finish,
                                  content: Column(
                                    children: [
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        textAlign: TextAlign.center,
                                        AppTexts.areYouSureWantFinishGame,
                                        style: AppTextStyles.news16.copyWith(),
                                      ),
                                      SizedBox(
                                        height: ResponsiveExtension.screenHeight / 35,
                                      ),
                                    ],
                                  ),
                                  button1BackColor: AppColors.layerOne,
                                  onTap1Text: AppTexts.fINISHGAME,
                                  onTap2Text: AppTexts.cANCEL,
                                  onTap1: () {
                                    if (GameState.timer != null) GameState.timer!.cancel();
                                    gameCubit!.saveData();
                                    NavigatorService.pushNamedAndRemoveUntil(
                                      context: context,
                                      AppRoutes.game2,
                                    );
                                  },
                                  onTap2: () {
                                    Navigator.pop(context);
                                  },
                                ),
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
            ),
          );
        });
  }
}

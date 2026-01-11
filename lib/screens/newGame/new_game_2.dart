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
import '../globalWidgets/custom_image_view.dart';
import '../globalWidgets/empthy_fields_widget.dart';
import '../globalWidgets/field_widget.dart';
import '../myFields/widgets/custom_bottom_sheet.dart';
import '../theme/app_colors.dart';
import '../theme/app_texts.dart';

class NewGame2 extends StatefulWidget {
  const NewGame2({super.key});

  @override
  State<NewGame2> createState() => _NewGame2State();
}

class _NewGame2State extends State<NewGame2> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        NewGameCubit.newGameCubit!.getFields();
      },
    );
    super.initState();
  }

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
                    rightWidget: GestureDetector(
                      onTap: () {
                        CustomBottomSheet.showBlurBottomSheet(
                          context,
                          pageType: 1,
                        );
                      },
                      child: CustomImageView(
                        imagePath: Assets.images.addField.path,
                        width: ResponsiveExtension.screenWidth / 10,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: List.generate(
                                state.fields.length,
                                (index) {
                                  return AnimatedOpacity(
                                    duration: const Duration(
                                      milliseconds: 150,
                                    ),
                                    opacity: state.chosenFieldId == null
                                        ? 1
                                        : state.chosenFieldId == index
                                            ? 1
                                            : 0.3,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      child: FieldWidget(
                                        field: state.fields[index].image,
                                        onTap: () {
                                          NewGameCubit.newGameCubit!.choseField(index);
                                        },
                                        courtName: state.fields[index].courtName,
                                        distance: state.fields[index].distance == null
                                            ? '1,200'
                                            : state.fields[index].distance.toString(),
                                        chackBoxVisible: state.chosenFieldId == null
                                            ? false
                                            : state.chosenFieldId == index
                                                ? true
                                                : false,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          if (state.fields.isEmpty)
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  FieldWidget(
                                    onTap: () {},
                                    courtName: 'Default without a field'.toUpperCase(),
                                    distance: '1,200',
                                  ),
                                  const EmpthyFieldsWidget(
                                    topPadding: 15,
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
                        text: AppTexts.sELECTSTARTGAME,
                        backColor:
                            state.chosenFieldId == null ? AppColors.layerThree : AppColors.layerOne,
                        onTap: () {
                          if (state.chosenFieldId == null) return;

                          NewGameCubit.newGameCubit!.save();
                          NewGameCubit.newGameCubit!.clearData();

                          NewGameCubit.newGameCubit!.initFirstPlayers();

                          NavigatorService.pushNamedAndRemoveUntil(
                            context: context,
                            AppRoutes.game,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

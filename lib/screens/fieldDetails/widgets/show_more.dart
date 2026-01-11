import 'dart:ui';

import 'package:app_b_839/screens/globalWidgets/custom_image_view.dart';
import 'package:app_b_839/screens/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/size_utils.dart';
import '../../../cubit/fieldDetailsCubit/field_details_state.dart';
import '../../../gen/assets.gen.dart';
import '../../globalWidgets/custom_cup_dialog.dart';
import '../../myFields/widgets/custom_bottom_sheet.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_texts.dart';
import '../field_details.dart';

class ShowMore extends StatelessWidget {
  const ShowMore({
    super.key,
    required this.state,
  });
  final FieldDetailsState state;
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      blendMode: BlendMode.srcOver,
      filter: ImageFilter.blur(sigmaX: 4.5, sigmaY: 4.5),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.only(
                right: 15,
                top: ResponsiveExtension.screenWidth / 4,
              ),
              width: ResponsiveExtension.screenWidth / 1.5,
              decoration: BoxDecoration(
                color: AppColors.backgroundOne,
                borderRadius: BorderRadius.circular(
                  8,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      FieldDetails.fieldDetailsCubit!.shareField(
                          screenshotController: FieldDetailsState.screenshotController,
                          imagePath: state.field!.image,
                          name: state.field!.courtName,
                          address: state.field!.adress,
                          description: state.field!.description ?? '');
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      padding: const EdgeInsets.only(
                        bottom: 12,
                        left: 10,
                        right: 10,
                        top: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppTexts.share,
                            style: AppTextStyles.bold16.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          CustomImageView(
                            imagePath: Assets.images.share.path,
                            width: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    color: AppColors.backgroundOne,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      CustomBottomSheet.showBlurBottomSheet(
                        context,
                        fieldId: state.fieldId,
                        pageType: 0,
                      );
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.only(
                        bottom: 12,
                        left: 10,
                        right: 10,
                        top: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppTexts.edit,
                            style: AppTextStyles.bold16.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          CustomImageView(
                            imagePath: Assets.images.edit.path,
                            width: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 7,
                    color: AppColors.backgroundOne,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) => CustomAlertDialog(
                          title: AppTexts.removeField,
                          content: Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                AppTexts.areYouSureWantToRemoveField,
                                style: AppTextStyles.news16.copyWith(),
                              ),
                              SizedBox(
                                height: ResponsiveExtension.screenHeight / 35,
                              ),
                            ],
                          ),
                          button1BackColor: AppColors.layerOne,
                          onTap1Text: AppTexts.removeField,
                          onTap2Text: AppTexts.cANCEL,
                          onTap1: () {
                            FieldDetails.fieldDetailsCubit!.removeCourte(state.fieldId!, context);
                          },
                          onTap2: () {
                            Navigator.pop(context);
                          },
                        ),
                      );
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      padding: const EdgeInsets.only(
                        bottom: 12,
                        left: 10,
                        right: 10,
                        top: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppTexts.removeCourt,
                            style: AppTextStyles.bold16.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.accentOne,
                            ),
                          ),
                          CustomImageView(
                            imagePath: Assets.images.clearApp.path,
                            width: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

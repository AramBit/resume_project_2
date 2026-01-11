import 'dart:ui';

import 'package:app_b_839/cubit/addFieldCubit/add_field_state.dart';
import 'package:app_b_839/screens/globalWidgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/size_utils.dart';
import '../../../cubit/addFieldCubit/add_field_cubit.dart';
import '../../../gen/assets.gen.dart';
import '../../globalWidgets/custom_image_view.dart';
import '../../globalWidgets/custom_text_field.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_texts.dart';

class CustomBottomSheet {
  static void showBlurBottomSheet(BuildContext context,
      {int? fieldId, required int pageType}) async {
    AddFieldCubit addFieldCubit = context.read<AddFieldCubit>();
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "blur_bottom_sheet",
      transitionDuration: const Duration(milliseconds: 100),
      pageBuilder: (context, anim1, anim2) {
        return BlocBuilder<AddFieldCubit, AddFieldState>(
            bloc: addFieldCubit,
            buildWhen: (previous, current) {
              return true;
            },
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.only(top: ResponsiveExtension.screenHeight / 15),
                child: Scaffold(
                  backgroundColor: Colors.black.withOpacity(0.1),
                  body: Stack(
                    children: [
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                        child: Container(
                          color: Colors.black.withOpacity(
                            0,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: GestureDetector(
                          onTap: () {
                            addFieldCubit.changeStateAdressesWindow(false);
                            FocusScope.of(context).unfocus();
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height / 1.3,
                            padding: const EdgeInsets.only(
                              top: 20,
                              left: 20,
                              right: 20,
                            ),
                            decoration: const BoxDecoration(
                              color: AppColors.backgroundTwo,
                              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 17,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                                addFieldCubit.clearData();
                                              },
                                              child: Container(
                                                color: Colors.transparent,
                                                width: ResponsiveExtension.screenWidth / 15,
                                                child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: CustomImageView(
                                                    imagePath: Assets.images.back.path,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 10),
                                                child: Center(
                                                  child: Text(
                                                    fieldId == null
                                                        ? AppTexts.aDDFIELD
                                                        : AppTexts.eDITFIELD,
                                                    style: AppTextStyles.heavyItalic32.copyWith(
                                                      color: AppColors.accentTwo,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize:
                                                          ResponsiveExtension.screenWidth / 15,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          AppTexts.hereYouCanAddYourField,
                                          style: AppTextStyles.news16.copyWith(
                                            color: AppColors.layerThree,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context).size.height / 5,
                                          width: double.infinity,
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.circular(
                                                  6,
                                                ),
                                                child: CustomImageView(
                                                  imagePath: state.image ??
                                                      Assets.images.imagePlaceholder.path,
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: GestureDetector(
                                                  onTap: () {},
                                                  child: Container(
                                                    color: Colors.transparent,
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        addFieldCubit.addImage();
                                                      },
                                                      child: CustomImageView(
                                                        imagePath:
                                                            Assets.images.btnAddWithBlock.path,
                                                        width: 44,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        CustomTextField(
                                          maxLength: 32,
                                          maxLines: 1,
                                          titleName: AppTexts.courtName,
                                          titleVisible: state.nameTitleViewer,
                                          onChange: addFieldCubit.onChangeName,
                                          controller: AddFieldState.nameController,
                                          hintText: AppTexts.enterYourName,
                                          fieldRightWidget: !state.nameTitleViewer
                                              ? null
                                              : GestureDetector(
                                                  onTap: () {
                                                    addFieldCubit.clearField(0, context);
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets.only(
                                                      left: 18,
                                                      right: 18,
                                                    ),
                                                    color: AppColors.backgroundOne,
                                                    child: CustomImageView(
                                                      imagePath: Assets.images.close.path,
                                                      width: 20,
                                                    ),
                                                  ),
                                                ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        CustomTextField(
                                          focusNode: AddFieldState.addressFocusNode,
                                          maxLength: 260,
                                          maxLines: 1,
                                          titleName: AppTexts.cOURTADRESS,
                                          titleVisible: state.adressTitleViewer,
                                          onChange: addFieldCubit.onChangeAdress,
                                          controller: AddFieldState.adressController,
                                          hintText: AppTexts.enterFieldAdress,
                                          fieldRightWidget: !state.adressTitleViewer
                                              ? null
                                              : GestureDetector(
                                                  onTap: () {
                                                    addFieldCubit.clearField(1, context);
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets.only(
                                                      left: 18,
                                                      right: 18,
                                                    ),
                                                    color: AppColors.backgroundOne,
                                                    child: CustomImageView(
                                                      imagePath: Assets.images.close.path,
                                                      width: 20,
                                                    ),
                                                  ),
                                                ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        CustomTextField(
                                          horizontalPadding: 20,
                                          maxLength: 260,
                                          maxLines: 1,
                                          titleName: AppTexts.dESCRIPTION,
                                          titleVisible: state.descriptionTitleViewer,
                                          onChange: addFieldCubit.onChangeDescription,
                                          controller: AddFieldState.descriptionController,
                                          hintText: AppTexts.enterDescription,
                                          fieldRightWidget: !state.descriptionTitleViewer
                                              ? null
                                              : GestureDetector(
                                                  onTap: () {
                                                    addFieldCubit.clearField(2, context);
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets.only(
                                                      left: 18,
                                                      right: 18,
                                                    ),
                                                    color: AppColors.backgroundOne,
                                                    child: CustomImageView(
                                                      imagePath: Assets.images.close.path,
                                                      width: 20,
                                                    ),
                                                  ),
                                                ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: ResponsiveExtension.screenHeight / 25,
                                ),
                                MainButton(
                                  backColor: state.buttonisActive
                                      ? AppColors.layerOne
                                      : AppColors.layerThree,
                                  text: fieldId == null ? AppTexts.aDD : AppTexts.sAVECHANGES,
                                  onTap: () {
                                    addFieldCubit.saveField(
                                      context,
                                      fieldId: fieldId,
                                      fieldType: pageType,
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: ResponsiveExtension.screenHeight / 25,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (state.adressSearchedInfo && state.adresses.isNotEmpty)
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: ResponsiveExtension.screenHeight / 10,
                            decoration: BoxDecoration(
                              color: AppColors.backgroundTwo,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  offset: const Offset(0, 4),
                                  blurRadius: 16,
                                  spreadRadius: 0,
                                ),
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  offset: const Offset(0, 1),
                                  blurRadius: 2,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: List.generate(state.adresses.length, (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      addFieldCubit.chosesRecomendedAdress(index);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                        top: 3,
                                        left: 25,
                                        bottom: 3,
                                        right: 10,
                                      ),
                                      decoration: const BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border(
                                          right: BorderSide(
                                            width: 1,
                                            color: AppColors.layerTwo,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        state.adresses[index],
                                        style: AppTextStyles.extraBold16,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            });
      },
      transitionBuilder: (context, animation, _, child) {
        final curvedValue = Curves.easeInOut.transform(animation.value);
        return Transform.translate(
          offset: Offset(0, (1 - curvedValue) * 200),
          child: Opacity(opacity: animation.value, child: child),
        );
      },
    );
    addFieldCubit.getEditData(fieldId);
  }
}

import 'dart:io';

import 'package:flutter/material.dart';

import '../../core/utils/size_utils.dart';
import '../../gen/assets.gen.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_texts.dart';
import 'custom_image_view.dart';

class FieldWidget extends StatelessWidget {
  const FieldWidget({
    super.key,
    required this.courtName,
    required this.distance,
    this.field,
    required this.onTap,
    this.chackBoxVisible = false,
  });
  final String? distance;
  final String courtName;
  final String? field;
  final Function()? onTap;
  final bool chackBoxVisible;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(
          top: 1,
          left: 1,
          right: 1,
        ),
        decoration: BoxDecoration(
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
          color: AppColors.backgroundTwo,
          borderRadius: BorderRadius.circular(
            8,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
              child: Stack(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          6,
                        ),
                        child: field == null
                            ? CustomImageView(
                                imagePath: Assets.images.imagePlaceholder.path,
                                width: double.infinity,
                              )
                            : Image.file(
                                File(
                                  field!,
                                ),
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                      ),
                      if (chackBoxVisible)
                        CustomImageView(
                          imagePath: Assets.images.checkBox.path,
                          width: 64,
                        ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 15,
                        right: 15,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: const Color(0xffa1abb5),
                        ),
                        color: const Color(0xff82939e).withOpacity(
                          0.95,
                        ),
                        borderRadius: BorderRadius.circular(
                          6,
                        ),
                      ),
                      child: Text.rich(
                        textAlign: TextAlign.center,
                        TextSpan(
                          children: [
                            TextSpan(
                              text: AppTexts.dIStance,
                              style: AppTextStyles.bold12.copyWith(
                                color: AppColors.layerTwo,
                                fontWeight: FontWeight.bold,
                                fontSize: ResponsiveExtension.screenWidth / 35,
                              ),
                            ),
                            TextSpan(
                              text: distance == null ? '   NO DATA' : '   $distance METERS',
                              style: AppTextStyles.bold12.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: ResponsiveExtension.screenWidth / 35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppTexts.courtName,
                    style: AppTextStyles.bold12.copyWith(
                      color: AppColors.layerThree,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      courtName,
                      textAlign: TextAlign.end,
                      style: AppTextStyles.bold12.copyWith(
                        color: AppColors.layerOne,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

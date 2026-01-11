import 'dart:io';

import 'package:flutter/material.dart';

import '../../../core/utils/size_utils.dart';
import '../../../gen/assets.gen.dart';
import '../../globalWidgets/custom_image_view.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_texts.dart';

class FieldDescriptionWidget extends StatelessWidget {
  const FieldDescriptionWidget({
    super.key,
    required this.addres,
    required this.courtName,
    required this.description,
    this.image,
  });
  final String courtName;
  final String addres;
  final String description;
  final String? image;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        20,
      ),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 5,
            width: double.infinity,
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                6,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                6,
              ),
              child: image != null
                  ? Image.file(
                      File(
                        image!,
                      ),
                      fit: BoxFit.cover,
                    )
                  : CustomImageView(
                      imagePath: Assets.images.imagePlaceholder.path,
                      width: ResponsiveExtension.screenWidth / 10,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                6,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppTexts.courtName,
                        style: AppTextStyles.bold12.copyWith(
                          color: AppColors.layerThree,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          courtName.toUpperCase(),
                          textAlign: TextAlign.end,
                          style: AppTextStyles.bold12.copyWith(
                            color: AppColors.layerOne,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppTexts.addres,
                        style: AppTextStyles.bold12.copyWith(
                          color: AppColors.layerThree,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          addres.toUpperCase(),
                          textAlign: TextAlign.end,
                          style: AppTextStyles.bold12.copyWith(
                            color: AppColors.layerOne,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  AppTexts.dESCRIPTION,
                  style: AppTextStyles.bold12.copyWith(
                    color: AppColors.layerThree,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  description,
                  style: AppTextStyles.news14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';

import '../../core/utils/size_utils.dart';
import '../../gen/assets.gen.dart';
import '../theme/app_colors.dart';
import 'custom_image_view.dart';

class AddImageCard extends StatelessWidget {
  const AddImageCard({
    super.key,
    this.background,
    this.onTap,
    this.editOnTap,
  });
  final Function()? onTap;
  final Function()? editOnTap;

  final String? background;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              image: background == null
                  ? null
                  : DecorationImage(
                      image: FileImage(File(background!)),
                      fit: BoxFit.cover,
                    ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            width: double.infinity,
            height: ResponsiveExtension.screenHeight / 5,
            child: onTap == null
                ? const SizedBox()
                : Center(
                    child: Container(
                      width: ResponsiveExtension.screenWidth / 7,
                      height: ResponsiveExtension.screenWidth / 7,
                      decoration: BoxDecoration(
                        color: AppColors.accentOne,
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),
                      child: Center(
                        child: CustomImageView(
                          imagePath: Assets.images.addField.path,
                          width: ResponsiveExtension.screenWidth / 13,
                        ),
                      ),
                    ),
                  ),
          ),
        ),
        if (editOnTap != null)
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: editOnTap,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 10,
                ),
                child: CustomImageView(
                  imagePath: Assets.images.addPhoto.path,
                  width: 50,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

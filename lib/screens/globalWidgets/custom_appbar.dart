import 'package:flutter/material.dart';

import '../../core/utils/size_utils.dart';
import '../../gen/assets.gen.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'custom_image_view.dart';

class CustomAppBar extends StatelessWidget {
  final Function()? backOnTap;
  final Widget? rightWidget;
  final String? text;
  const CustomAppBar({
    super.key,
    this.text,
    this.backOnTap,
    this.rightWidget,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
        padding: EdgeInsets.only(
          top: ResponsiveExtension.screenWidth / 6,
          bottom: ResponsiveExtension.screenWidth / 20,
          left: 25,
          right: 25,
        ),
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
        width: double.maxFinite,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (backOnTap != null)
              GestureDetector(
                onTap: backOnTap,
                child: Container(
                    color: Colors.transparent,
                    width: ResponsiveExtension.screenWidth / 15,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomImageView(
                        imagePath: Assets.images.back.path,
                      ),
                    )),
              ),
            if (text != null)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Center(
                    child: Text(
                      text!,
                      style: AppTextStyles.heavyItalic32.copyWith(
                        color: AppColors.accentTwo,
                        fontSize: ResponsiveExtension.screenWidth / 15,
                      ),
                    ),
                  ),
                ),
              ),
            if (backOnTap != null)
              Container(
                padding: const EdgeInsets.only(
                  right: 20,
                ),
                width: 30,
              ),
            if (rightWidget != null) rightWidget!,
          ],
        ),
      ),
    );
  }
}

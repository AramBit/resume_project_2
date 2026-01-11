import 'package:flutter/material.dart';

import '../../globalWidgets/custom_image_view.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class SettingsRow extends StatelessWidget {
  const SettingsRow({
    super.key,
    required this.onTap,
    required this.text,
    this.topLeft,
    this.topRight,
    this.bottomLeft,
    this.bottomRight,
    required this.rightWidget,
    this.textColor,
    required this.icon,
    this.borderBottomVisibility = true,
  });
  final String text;
  final Function()? onTap;
  final double? topLeft;
  final double? topRight;
  final double? bottomLeft;
  final double? bottomRight;
  final Widget rightWidget;
  final Color? textColor;
  final String icon;
  final bool borderBottomVisibility;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          border: borderBottomVisibility
              ? const Border(
                  bottom: BorderSide(
                    width: 1,
                    color: AppColors.backgroundOne,
                  ),
                )
              : null,
        ),
        child: InkWell(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topLeft ?? 0),
            topRight: Radius.circular(topRight ?? 0),
            bottomLeft: Radius.circular(bottomLeft ?? 0),
            bottomRight: Radius.circular(bottomRight ?? 0),
          ),
          splashColor: AppColors.accentOne.withOpacity(0.1),
          highlightColor: AppColors.accentOne.withOpacity(0.1),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomImageView(
                  imagePath: icon,
                  width: 30,
                  height: 26,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.extraBold16.copyWith(
                      color: textColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                rightWidget
              ],
            ),
          ),
        ),
      ),
    );
  }
}

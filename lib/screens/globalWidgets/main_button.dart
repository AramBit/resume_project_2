import 'package:flutter/material.dart';

import '../../core/utils/size_utils.dart';
import '../../gen/fonts.gen.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    this.gradient,
    this.backColor = AppColors.layerOne,
    required this.text,
    required this.onTap,
    this.textColor = AppColors.backgroundTwo,
    this.loading = false,
  });
  final List<Color>? gradient;
  final Color backColor;
  final String text;
  final Color textColor;
  final Function()? onTap;
  final bool loading;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        backgroundColor: backColor,
        shadowColor: Colors.transparent,
      ),
      child: Ink(
        height: 60,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          gradient: gradient == null
              ? null
              : LinearGradient(
                  begin: Alignment.centerLeft, end: Alignment.centerRight, colors: gradient!),
          borderRadius: BorderRadius.circular(6),
        ),
        child: loading
            ? const Center(
                child: SizedBox(
                  width: 25,
                  height: 25,
                  child: FittedBox(
                    child: CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                      backgroundColor: AppColors.circlBackground,
                      color: AppColors.accentTwo,
                      strokeWidth: 6,
                    ),
                  ),
                ),
              )
            : Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          text,
                          style: AppTextStyles.extraBold16.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: FontFamily.codecProBold,
                            color: textColor,
                            fontSize: ResponsiveExtension.screenWidth / 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

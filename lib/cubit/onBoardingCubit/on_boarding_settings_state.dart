import 'package:flutter/material.dart';

class OnBoardingSettingsState {
  OnBoardingSettingsState({
    this.buttonIsActive = false,
    this.titleNameVisibility = false,
  });
  static TextEditingController controller = TextEditingController();
  bool buttonIsActive;
  bool titleNameVisibility;
  OnBoardingSettingsState copyWith({
    bool? copybuttonIsActive,
    bool? copytitleNameVisibility,
  }) {
    return OnBoardingSettingsState(
      buttonIsActive: copybuttonIsActive ?? buttonIsActive,
      titleNameVisibility: copytitleNameVisibility ?? titleNameVisibility,
    );
  }
}

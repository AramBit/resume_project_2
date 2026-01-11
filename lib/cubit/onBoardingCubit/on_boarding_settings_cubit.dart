import 'package:flutter_bloc/flutter_bloc.dart';

import 'on_boarding_settings_state.dart';

class OnBoardingSettingsCubit extends Cubit<OnBoardingSettingsState> {
  static OnBoardingSettingsCubit? homeCubit;
  OnBoardingSettingsCubit()
      : super(
          OnBoardingSettingsState(),
        );
  void clearData() {
    emit(
      state.copyWith(
        copybuttonIsActive: false,
        copytitleNameVisibility: false,
      ),
    );
  }

  void saveName() {}

  void onChangeName(String value) {
    String formattedValue = value.replaceAll(' ', '');
    bool titleNameVisibility = true;
    bool buttonIsActive = true;

    if (formattedValue.length < 3) {
      titleNameVisibility = false;
      buttonIsActive = false;
    }
    emit(
      state.copyWith(
        copytitleNameVisibility: titleNameVisibility,
        copybuttonIsActive: buttonIsActive,
      ),
    );
  }
}

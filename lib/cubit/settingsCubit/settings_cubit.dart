import 'package:flutter_bloc/flutter_bloc.dart';

import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  static SettingsCubit? settingsCubit;
  SettingsCubit() : super(SettingsState());

  void clearData() {
    emit(
      state.copyWith(
        copyuserBoxLoading: false,
        copyUserStatus: false,
        copyUser: null,
      ),
    );
  }

  void isLoaded() {
    emit(
      state.copyWith(
        copyUserStatus: false,
      ),
    );
  }
}

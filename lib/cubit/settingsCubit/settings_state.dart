class SettingsState {
  final bool userBoxLoading;
  final bool userStatus;

  SettingsState({
    this.userBoxLoading = false,
    this.userStatus = false,
  });

  SettingsState copyWith({
    Object? copyUser = _noValue,
    bool? copyuserBoxLoading,
    bool? copyUserStatus,
  }) {
    return SettingsState(
      userBoxLoading: copyuserBoxLoading ?? userBoxLoading,
      userStatus: copyUserStatus ?? userStatus,
    );
  }

  static const _noValue = Object();
}

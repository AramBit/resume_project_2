import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  static HomeCubit? homeCubit;
  HomeCubit()
      : super(
          HomeState(),
        );
  void clearData() {
    emit(
      state.copyWith(
        copycategoryIndex: 0,
        copynumberOfEvent: 0,
        copynumberOfposter: 0,
      ),
    );
  }
}

import 'package:app_b_839/model/field_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';

import '../../core/utils/location_adress_route_service.dart';
import '../addFieldCubit/add_field_cubit.dart';
import 'my_fields_state.dart';

class MyFieldsCubit extends Cubit<MyFieldsState> {
  static MyFieldsCubit? myFieldsCubit;
  MyFieldsCubit()
      : super(
          MyFieldsState(),
        );
  void clearData() {
    emit(
      state.copyWith(),
    );
  }

  static String formatDistance(double distance) {
    final distanceStr = distance.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );

    return distanceStr;
  }

  void addDistancesToField() async {
    final location = Location();
    PermissionStatus permissionGranted = await location.hasPermission();

    if (permissionGranted != PermissionStatus.granted) {
      return;
    }

    List<FieldModel> result = AddFieldCubit.getFieldAsAnList();
    for (FieldModel element in result) {
      double? distance = await LocationAddressRouteService().requestToKnowDistance(
        address: element.adress,
      );

      element.distance = distance;
      emit(
        state.copyWith(
          copyfields: result,
        ),
      );
    }
  }

  List<FieldModel> getFields() {
    List<FieldModel> result = AddFieldCubit.getFieldAsAnList();
    emit(
      state.copyWith(
        copyfields: result,
      ),
    );
    addDistancesToField();
    return result;
  }
}

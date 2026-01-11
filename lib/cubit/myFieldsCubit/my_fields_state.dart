import 'package:app_b_839/model/field_model.dart';

class MyFieldsState {
  MyFieldsState({
    this.fields = const [],
  });
  final List<FieldModel> fields;
  MyFieldsState copyWith({
    List<FieldModel>? copyfields,
  }) {
    return MyFieldsState(
      fields: copyfields ?? fields,
    );
  }
}

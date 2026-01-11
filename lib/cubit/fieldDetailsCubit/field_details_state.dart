import 'package:app_b_839/model/field_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:screenshot/screenshot.dart';

class FieldDetailsState {
  static MapController mapController = MapController();
  static ScreenshotController screenshotController = ScreenshotController();
  FieldDetailsState({
    this.field,
    this.fieldId,
    this.currentFieldLocationLat = 0,
    this.currentFieldLocationLon = 0,
    this.currentFieldLocationStartLat = 0,
    this.currentFieldLocationStartLon = 0,
    this.distance,
    this.availableApp = const [],
    this.markers = const [],
  });
  final List<Marker> markers;
  final List<MapApp> availableApp;
  final FieldModel? field;
  final int? fieldId;
  final double currentFieldLocationLat;
  final double currentFieldLocationLon;
  final double currentFieldLocationStartLat;
  final double currentFieldLocationStartLon;
  final double? distance;

  FieldDetailsState copyWith({
    FieldModel? copyfield,
    int? copyfieldId,
    double? copycurrentFieldLocationLat,
    double? copycurrentFieldLocationLon,
    double? copycurrentFieldLocationStartLat,
    double? copycurrentFieldLocationStartLon,
    double? copydistance,
    List<Marker>? copymarkers,
    List<MapApp>? copyavailableApp,
  }) {
    return FieldDetailsState(
      field: copyfield ?? field,
      fieldId: copyfieldId ?? fieldId,
      currentFieldLocationLat: copycurrentFieldLocationLat ?? currentFieldLocationLat,
      currentFieldLocationLon: copycurrentFieldLocationLon ?? currentFieldLocationLon,
      currentFieldLocationStartLat:
          copycurrentFieldLocationStartLat ?? currentFieldLocationStartLat,
      currentFieldLocationStartLon:
          copycurrentFieldLocationStartLon ?? currentFieldLocationStartLon,
      distance: copydistance ?? distance,
      markers: copymarkers ?? markers,
      availableApp: copyavailableApp ?? availableApp,
    );
  }
}

class MapApp {
  final String name;
  final IconData icon;
  final String url;
  MapApp({required this.name, required this.icon, required this.url});
}

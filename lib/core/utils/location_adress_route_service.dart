import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class LocationAddressRouteService {
  final String mapboxApiKey =
      'pk.eyJ1IjoiaXZhdDEyMyIsImEiOiJjbWU4cDJjdW8waHM3MmtzOHA2NWZmdGU2In0.oLVl0Rm5ZJrB9vs8ycjQBw';

  LocationAddressRouteService();

  Future<LocationData?> getCurrentLocation() async {
    final location = Location();

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled && !await location.requestService()) return null;

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied &&
        await location.requestPermission() != PermissionStatus.granted) return null;

    try {
      return await Future.any([
        location.getLocation(),
        Future.delayed(const Duration(seconds: 5), () {
          print('⚠️ Локация не получена за 5 секунд.');
          return null;
        }),
      ]);
    } catch (e) {
      print('Ошибка получения локации: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> mapboxGeocode(String address) async {
    final url = Uri.parse(
      'https://api.mapbox.com/geocoding/v5/mapbox.places/${Uri.encodeComponent(address)}.json'
      '?access_token=$mapboxApiKey&limit=1&autocomplete=false&types=place,address',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['features'] != null && data['features'].isNotEmpty) {
        final feature = data['features'][0];
        final coords = feature['geometry']['coordinates'];
        return {'lat': coords[1], 'lng': coords[0], 'place_name': feature['place_name']};
      }
    }
    print("Mapbox: адрес не найден");
    return null;
  }

  Future<Map<String, dynamic>?> getRouteMapbox(
      double startLat, double startLng, double endLat, double endLng) async {
    final url = Uri.parse(
      'https://api.mapbox.com/directions/v5/mapbox/driving/$startLng,$startLat;$endLng,$endLat'
      '?geometries=geojson&overview=full&access_token=$mapboxApiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Mapbox Directions error: ${response.statusCode}');
      return null;
    }
  }

  Future<double?> requestToKnowDistance({String address = "New York, USA"}) async {
    final geo = await mapboxGeocode(address);
    if (geo == null) {
      return null;
    }

    final currentLocation = await getCurrentLocation();
    if (currentLocation == null) {
      print("Не удалось получить текущую локацию");
      return null;
    }

    final route = await getRouteMapbox(
      currentLocation.latitude!,
      currentLocation.longitude!,
      geo['lat'],
      geo['lng'],
    );

    if (route != null && route['routes'].isNotEmpty) {
      final distanceMeters = route['routes'][0]['distance'].toDouble();
      // final durationSeconds = route['routes'][0]['duration'];
      return distanceMeters;
    }
    return null;
  }
}

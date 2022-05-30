import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

/// Logs technician's current location into the backend if first time, or have moved 100m away from before
/// Recurs every 10 seconds
class LocationService {
  // init({intervalSeconds: 10}) async {
  //   Position prevPos;
  //   // SharedPreferencesUtils.clear();
  //   Timer.periodic(
  //     new Duration(seconds: intervalSeconds),
  //         (timer) async {
  //       bool authTokenIsSet = await SharedPreferencesUtils.isAuthTokenSet();
  //       if (authTokenIsSet && await Permission.location.request().isGranted) {
  //         int technicianId = await SharedPreferencesUtils.getTechnicianId();
  //         if (prevPos == null) {
  //           print("POST /technician_locations");
  //           prevPos = await _getTechnicianPosition();
  //           ApiService.postWithoutContext("/technician_locations", {
  //             "longitude": prevPos.longitude,
  //             "latitude": prevPos.latitude,
  //             "technician": technicianId
  //           });
  //         } else {
  //           Position currentPos = await _getTechnicianPosition();
  //           double distance = Geolocator.distanceBetween(prevPos.latitude,
  //               prevPos.longitude, currentPos.latitude, currentPos.longitude);
  //           // print(distance);
  //           if (distance > 100) {
  //             print(
  //                 "${prevPos.latitude},${prevPos.longitude} => ${currentPos.latitude},${currentPos.longitude}");
  //             print("POST /technician_locations - distance changed");
  //             prevPos = currentPos;
  //             ApiService.postWithoutContext("/technician_locations", {
  //               "longitude": currentPos.longitude,
  //               "latitude": currentPos.latitude,
  //               "technician": technicianId
  //             });
  //           }
  //         }
  //       }
  //     },
  //   );
  // }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
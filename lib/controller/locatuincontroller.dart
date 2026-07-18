import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  var location = 'Fetching location...'.obs;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      location.value = 'Location disabled';
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      location.value = 'Permission denied';
      return;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        location.value = 'Permission denied';
        return;
      }
    }

    Position pos = await Geolocator.getCurrentPosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(pos.latitude, pos.longitude);

    if (placemarks.isNotEmpty) {
      final placemark = placemarks.first;
      location.value = "${placemark.locality}, ${placemark.country}";
    }
  }
}

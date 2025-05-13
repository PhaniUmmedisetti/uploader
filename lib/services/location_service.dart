import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../constants/app_strings.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar(
          AppStrings.errorTitle,
          'Location services are disabled. Please enable them in your device settings.',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
        );
        throw 'Location services are disabled.';
      }

      // Check and request location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar(
            AppStrings.errorTitle,
            'Location permissions are denied. Please allow access to location in app settings.',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 5),
          );
          throw 'Location permissions are denied.';
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar(
          AppStrings.errorTitle,
          'Location permissions are permanently denied. Please enable them in app settings.',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
        );
        // Open app settings to allow the user to enable permissions
        await Geolocator.openAppSettings();
        throw 'Location permissions are permanently denied.';
      }

      // Get the current position
      return await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.best),
      );
    } catch (e) {
      Get.snackbar(
        AppStrings.errorTitle,
        'Failed to get location: $e',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
      rethrow;
    }
  }
}
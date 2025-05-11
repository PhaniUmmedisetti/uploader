import 'package:get/get.dart';
import '../controllers/language_controller.dart';
import '../controllers/upload_controller.dart';
import '../services/location_service.dart';
import '../services/storage_service.dart';
import '../services/database_service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Use Get.put() to instantiate immediately instead of Get.lazyPut()
    Get.put<LocationService>(LocationService());
    Get.put<StorageService>(StorageService());
    Get.put<DatabaseService>(DatabaseService());
    Get.put<LanguageController>(LanguageController());
    Get.put<UploadController>(UploadController());
  }
}
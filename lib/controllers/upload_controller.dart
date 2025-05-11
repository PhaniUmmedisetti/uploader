import 'dart:io';
import 'package:app_a/controllers/language_controller.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:permission_handler/permission_handler.dart'; // Added for camera permission
import '../localization/app_translations.dart';
import '../models/file.dart';
import '../services/location_service.dart';
import '../services/storage_service.dart';
import '../services/database_service.dart';
import '../constants/app_strings.dart';

class UploadController extends GetxController {
  final LocationService locationService = Get.find<LocationService>();
  final StorageService storageService = Get.find<StorageService>();
  final DatabaseService databaseService = Get.find<DatabaseService>();
  final LanguageController languageController = Get.find<LanguageController>();

  var selectedFile = Rxn<File>();
  var isUploading = false.obs;
  var isPickingFile = false.obs;
  var isCapturingImage = false.obs;
  var uploadMessage = Rxn<String>();
  var showUploadOptions = true.obs;

  Future<void> pickFile() async {
    try {
      isPickingFile.value = true;
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      );

      if (result != null && result.files.single.path != null) {
        final file = File(result.files.single.path!);
        if (_isValidFileType(file.path)) {
          selectedFile.value = file;
          showUploadOptions.value = false;
        } else {
          Get.snackbar(AppStrings.errorTitle, 'Invalid file type. Only images and PDFs are allowed.');
        }
      } else {
        Get.snackbar(AppStrings.errorTitle, 'No file selected');
      }
    } catch (e) {
      Get.snackbar(AppStrings.errorTitle, 'Failed to pick file: $e');
    } finally {
      isPickingFile.value = false;
    }
  }

  Future<void> captureImage() async {
    try {
      // Request camera permission
      var cameraStatus = await Permission.camera.status;
      if (!cameraStatus.isGranted) {
        cameraStatus = await Permission.camera.request();
        if (!cameraStatus.isGranted) {
          Get.snackbar(
            AppStrings.errorTitle,
            'Camera permission is required to take photos. Please enable it in app settings.',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 5),
          );
          if (cameraStatus.isPermanentlyDenied) {
            await openAppSettings();
          }
          return;
        }
      }

      isCapturingImage.value = true;
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        final file = File(pickedFile.path);
        if (_isValidFileType(file.path)) {
          selectedFile.value = file;
          showUploadOptions.value = false;
        } else {
          Get.snackbar(AppStrings.errorTitle, 'Invalid file type. Only images are allowed.');
        }
      } else {
        Get.snackbar(AppStrings.errorTitle, 'No image captured');
      }
    } catch (e) {
      Get.snackbar(AppStrings.errorTitle, 'Failed to capture image: $e');
    } finally {
      isCapturingImage.value = false;
    }
  }

  bool _isValidFileType(String filePath) {
    final extension = filePath.split('.').last.toLowerCase();
    return ['jpg', 'jpeg', 'png', 'pdf'].contains(extension);
  }

  Future<void> uploadFile() async {
    if (selectedFile.value == null) {
      Get.snackbar(AppStrings.errorTitle, 'No file selected');
      return;
    }

    isUploading.value = true;
    uploadMessage.value = null;

    try {
      final position = await locationService.getCurrentLocation();
      final lat = position.latitude;
      final long = position.longitude;

      final downloadUrl = await storageService.uploadFile(selectedFile.value!);

      final uploadedFile = UploadedFile(
        id: const Uuid().v4(),
        name: selectedFile.value!.path.split('/').last,
        url: downloadUrl,
        createdAt: DateTime.now(),
        lat: lat,
        long: long,
      );

      await databaseService.insertFile(uploadedFile);

      uploadMessage.value = AppTranslations.translate('uploadSuccess', languageController.locale.value);
      selectedFile.value = null;
      showUploadOptions.value = true;
    } catch (e) {
      uploadMessage.value = AppTranslations.translate('uploadFailed', languageController.locale.value);
      Get.snackbar(AppStrings.errorTitle, e.toString());
      showUploadOptions.value = true;
    } finally {
      isUploading.value = false;
    }
  }

  void resetUploadScreen() {
    selectedFile.value = null;
    uploadMessage.value = null;
    showUploadOptions.value = true;
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/upload_controller.dart';
import '../constants/app_colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../controllers/language_controller.dart';
import '../localization/app_translations.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uploadController = Get.find<UploadController>();
    final languageController = Get.find<LanguageController>();

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          title: Text(
            AppTranslations.translate('appTitle', languageController.locale.value),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
        ),
        backgroundColor: AppColors.backgroundColor,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (uploadController.showUploadOptions.value) ...[
                  uploadController.isPickingFile.value
                      ? const Center(
                          child: SpinKitCircle(
                            color: AppColors.primaryColor,
                            size: 50.0,
                          ),
                        )
                      : ElevatedButton.icon(
                          onPressed: uploadController.pickFile,
                          icon: const Icon(Icons.folder, size: 24),
                          label: Text(
                            AppTranslations.translate('selectFile', languageController.locale.value),
                            style: const TextStyle(fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                          ),
                        ),
                  const SizedBox(height: 16),
                  uploadController.isCapturingImage.value
                      ? const Center(
                          child: SpinKitCircle(
                            color: AppColors.primaryColor,
                            size: 50.0,
                          ),
                        )
                      : ElevatedButton.icon(
                          onPressed: uploadController.captureImage,
                          icon: const Icon(Icons.camera_alt, size: 24),
                          label: Text(
                            AppTranslations.translate('useCamera', languageController.locale.value),
                            style: const TextStyle(fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                          ),
                        ),
                  const SizedBox(height: 24),
                ],
                if (uploadController.selectedFile.value != null)
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'Selected: ${uploadController.selectedFile.value!.path.split('/').last}',
                              style: const TextStyle(fontSize: 16, color: Colors.black87),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.clear, color: AppColors.errorColor),
                            onPressed: () {
                              uploadController.selectedFile.value = null;
                              uploadController.showUploadOptions.value = true;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                if (uploadController.selectedFile.value != null) const SizedBox(height: 24),
                if (uploadController.isUploading.value)
                  Column(
                    children: [
                      const SpinKitCircle(color: AppColors.primaryColor, size: 50.0),
                      const SizedBox(height: 8),
                      Text(
                        AppTranslations.translate('uploading', languageController.locale.value),
                        style: const TextStyle(fontSize: 16, color: AppColors.primaryColor),
                      ),
                    ],
                  )
                else if (uploadController.selectedFile.value != null)
                  ElevatedButton(
                    onPressed: uploadController.uploadFile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    child: Text(
                      AppTranslations.translate('uploadButton', languageController.locale.value),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                if (uploadController.uploadMessage.value != null) ...[
                  const SizedBox(height: 24),
                  Text(
                    uploadController.uploadMessage.value!,
                    style: TextStyle(
                      color: uploadController.uploadMessage.value ==
                              AppTranslations.translate('uploadSuccess', languageController.locale.value)
                          ? AppColors.successColor
                          : AppColors.errorColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: uploadController.resetUploadScreen,
                    child: const Text(
                      'Upload Another File',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
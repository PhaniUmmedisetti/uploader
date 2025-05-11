import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/file.dart';
import '../services/database_service.dart';
// import '../constants/app_strings.dart';
import '../constants/app_colors.dart';
import '../controllers/language_controller.dart';
import '../localization/app_translations.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final databaseService = Get.find<DatabaseService>();
    final languageController = Get.find<LanguageController>();
    final arguments = Get.arguments;
    final Animation<double>? fadeAnimation = arguments != null ? arguments['animation'] : null;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Obx(
          () => Text(
            AppTranslations.translate('historyTab', languageController.locale.value),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2196F3), // AppColors.primaryColor (blue)
              Color(0xFFBBDEFB), // Lighter shade of blue
            ],
          ),
        ),
        child: FutureBuilder<List<UploadedFile>>(
          future: databaseService.fetchFiles(),
          builder: (context, snapshot) {
            Widget body;
            if (snapshot.connectionState == ConnectionState.waiting) {
              body = const Center(child: CircularProgressIndicator(color: Colors.white));
            } else if (snapshot.hasError) {
              body = Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            } else {
              final files = snapshot.data ?? [];
              if (files.isEmpty) {
                body = Center(
                  child: Obx(
                    () => Text(
                      AppTranslations.translate('noFiles', languageController.locale.value),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                );
              } else {
                body = ListView.builder(
                  padding: const EdgeInsets.all(16.0).copyWith(top: kToolbarHeight + 45),
                  itemCount: files.length,
                  itemBuilder: (context, index) {
                    final file = files[index];
                    return AnimatedOpacity(
                      opacity: fadeAnimation?.value ?? 1.0,
                      duration: const Duration(milliseconds: 300),
                      child: Card(
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        color: Colors.white.withOpacity(0.9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          leading: Icon(
                            _getFileIcon(file.name),
                            color: AppColors.primaryColor,
                            size: 30,
                          ),
                          title: Text(
                            file.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            'Uploaded at: ${file.createdAt.toLocal().toString().split('.')[0]}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.link,
                            color: AppColors.primaryColor,
                          ),
                          onTap: () {
                            Get.snackbar(
                              'File URL',
                              file.url,
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.white,
                              colorText: AppColors.primaryColor,
                              margin: const EdgeInsets.all(16),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              }
            }

            return body;
          },
        ),
      ),
    );
  }

  IconData _getFileIcon(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    if (extension == 'pdf') {
      return Icons.picture_as_pdf;
    } else if (['jpg', 'jpeg', 'png'].contains(extension)) {
      return Icons.image;
    }
    return Icons.insert_drive_file;
  }
}
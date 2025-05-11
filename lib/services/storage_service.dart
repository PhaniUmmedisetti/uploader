import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';
import '../constants/app_strings.dart';

class StorageService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<String> uploadFile(File file) async {
    try {
      final fileName = file.path.split('/').last;
      final filePath = '${AppStrings.storagePath}/${DateTime.now().millisecondsSinceEpoch}_$fileName';

      await _supabase.storage.from('uploads').upload(
            filePath,
            file,
            fileOptions: const FileOptions(upsert: true),
          );

      final publicUrl = _supabase.storage.from('uploads').getPublicUrl(filePath);

      return publicUrl;
    } catch (e) {
      Get.snackbar(AppStrings.errorTitle, 'Failed to upload file: $e');
      rethrow;
    }
  }
}
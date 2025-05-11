import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';
import '../models/file.dart';
import '../constants/app_strings.dart';

class DatabaseService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> insertFile(UploadedFile file) async {
    try {
      await _supabase.from(AppStrings.filesTable).insert(file.toJson());
    } catch (e) {
      Get.snackbar(AppStrings.errorTitle, 'Failed to store file metadata: $e');
      rethrow;
    }
  }

  Future<List<UploadedFile>> fetchFiles() async {
    try {
      final response = await _supabase
          .from(AppStrings.filesTable)
          .select()
          .order('created_at', ascending: false);
      return (response as List)
          .map((json) => UploadedFile.fromJson(json))
          .toList();
    } catch (e) {
      Get.snackbar(AppStrings.errorTitle, 'Failed to fetch files: $e');
      rethrow;
    }
  }
}
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';
import 'routes/routes.dart';
import 'bindings/app_bindings.dart';
import 'controllers/language_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://heplueyzwskdzfesuziq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhlcGx1ZXl6d3NrZHpmZXN1emlxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDY4ODY5OTgsImV4cCI6MjA2MjQ2Mjk5OH0.wrCip1jeZtuWIXAZW4nLDSytvNCHAV9h5JwbwBzPfqE',
  );
  await Future.delayed(const Duration(milliseconds: 100));

  // Small delay to ensure Supabase is fully initialized
  await Future.delayed(const Duration(milliseconds: 100));

  // Instantiate LanguageController before runApp
  Get.put<LanguageController>(LanguageController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        title: 'Uploader App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        locale: Get.find<LanguageController>().locale.value,
        initialRoute: AppRoutes.main,
        getPages: AppRoutes.getPages,
        defaultTransition: Transition.zoom,
        initialBinding: AppBindings(),
      ),
    );
  }
}
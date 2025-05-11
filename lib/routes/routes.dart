import 'package:get/get.dart';
import '../screens/main_screen.dart';
import '../screens/upload_screen.dart';
import '../screens/history_screen.dart';

class AppRoutes {
  static const String main = '/main';
  static const String upload = '/upload';
  static const String history = '/history';

  static List<GetPage> getPages = [
    GetPage(
      name: main,
      page: () => const MainScreen(),
    ),
    GetPage(
      name: upload,
      page: () => const UploadScreen(),
    ),
    GetPage(
      name: history,
      page: () => const HistoryScreen(),
    ),
  ];
}
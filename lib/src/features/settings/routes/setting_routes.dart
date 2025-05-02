import 'package:bloc_abstraction_example/src/features/settings/views/setting_view.dart';
import 'package:go_router/go_router.dart';

class SettingRoutes {
  static String get setting => '/setting';

  final routes = [
    GoRoute(
      path: setting,
      builder: (context, state) {
        return const SettingView();
      },
    ),
  ];
}

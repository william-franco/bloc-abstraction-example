import 'package:bloc_abstraction_example/src/common/dependency_injectors/dependency_injector.dart';
import 'package:bloc_abstraction_example/src/features/settings/view_models/setting_view_model.dart';
import 'package:bloc_abstraction_example/src/features/settings/views/setting_view.dart';
import 'package:go_router/go_router.dart';

class SettingRoutes {
  static String get setting => '/setting';

  List<GoRoute> get routes => _routes;

  final List<GoRoute> _routes = [
    GoRoute(
      path: setting,
      builder: (context, state) {
        return SettingView(settingViewModel: locator<SettingViewModel>());
      },
    ),
  ];
}

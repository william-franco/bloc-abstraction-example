import 'package:bloc_abstraction_example/src/features/settings/routes/setting_routes.dart';
import 'package:bloc_abstraction_example/src/features/users/routes/user_routes.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static final GoRouter routes = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: UserRoutes.users,
    routes: [
      ...UserRoutes.routes,
      ...SettingRoutes.routes,
    ],
  );
}

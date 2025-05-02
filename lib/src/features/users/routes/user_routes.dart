import 'package:bloc_abstraction_example/src/features/users/models/user_model.dart';
import 'package:bloc_abstraction_example/src/features/users/views/user_detail_view.dart';
import 'package:bloc_abstraction_example/src/features/users/views/user_view.dart';
import 'package:go_router/go_router.dart';

class UserRoutes {
  static String get users => '/users';
  static String get userDetail => '/users-detail';

  final routes = [
    GoRoute(
      path: users,
      builder: (context, state) {
        return const UserView();
      },
    ),
    GoRoute(
      path: userDetail,
      builder: (context, state) {
        final UserModel userModel = state.extra as UserModel;

        return UserDetailView(userModel: userModel);
      },
    ),
  ];
}

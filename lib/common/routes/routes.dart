import 'package:bloc_abstraction_example/features/users/models/user_model.dart';
import 'package:bloc_abstraction_example/features/users/views/user_detail_view.dart';
import 'package:bloc_abstraction_example/features/users/views/user_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final routesApp = Routes();

class Routes {
  static const String user = '/users';
  static const String userDetail = '/users-detail';

  final routes = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: user,
    routes: [
      GoRoute(
        path: user,
        pageBuilder: (context, state) => const MaterialPage(
          child: UserView(),
        ),
      ),
      GoRoute(
        path: userDetail,
        pageBuilder: (context, state) {
          final UserModel userModel = state.extra as UserModel;

          return MaterialPage(
            child: UserDetailView(userModel: userModel),
          );
        },
      ),
    ],
  );
}

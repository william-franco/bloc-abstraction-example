import 'package:bloc_abstraction_example/src/features/users/models/user_model.dart';
import 'package:bloc_abstraction_example/src/features/users/views/user_detail_view.dart';
import 'package:bloc_abstraction_example/src/features/users/views/user_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserRoutes {
  static const String users = '/users';
  static const String userDetail = '/users-detail';

  static final List<GoRoute> routes = [
    GoRoute(
      path: users,
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
  ];
}

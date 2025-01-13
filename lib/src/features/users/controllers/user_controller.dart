import 'package:bloc_abstraction_example/src/common/controllers/state_controller.dart';
import 'package:bloc_abstraction_example/src/common/exception_handlings/exception_handling.dart';
import 'package:bloc_abstraction_example/src/features/users/repositories/user_repository.dart';
import 'package:bloc_abstraction_example/src/features/users/states/user_state.dart';
import 'package:flutter/material.dart';

typedef _Controller = StateController<UserState>;

abstract interface class UserController extends _Controller {
  UserController() : super(UserInitialState());

  Future<void> getAllUsers();
}

class UserControllerImpl extends _Controller implements UserController {
  final UserRepository userRepository;

  UserControllerImpl({
    required this.userRepository,
  }) : super(UserInitialState());

  @override
  Future<void> getAllUsers() async {
    emitState(UserLoadingState());
    final result = await userRepository.findAllUsers();
    final users = switch (result) {
      Success(value: final users) => UserSuccessState(users: users),
      Error(error: final exception) =>
        UserErrorState(message: 'Something went wrong: $exception'),
    };
    emitState(users);
    _debug();
  }

  void _debug() {
    debugPrint('User state: $state');
  }
}

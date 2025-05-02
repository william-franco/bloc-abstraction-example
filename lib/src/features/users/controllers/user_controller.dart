import 'package:bloc_abstraction_example/src/common/controllers/state_controller.dart';
import 'package:bloc_abstraction_example/src/common/exception_handlings/exception_handling.dart';
import 'package:bloc_abstraction_example/src/common/states/state.dart';
import 'package:bloc_abstraction_example/src/features/users/models/user_model.dart';
import 'package:bloc_abstraction_example/src/features/users/repositories/user_repository.dart';
import 'package:flutter/material.dart';

typedef _Controller = StateController<AppState<List<UserModel>>>;

abstract interface class UserController extends _Controller {
  UserController() : super(InitialState());

  Future<void> getAllUsers();
}

class UserControllerImpl extends _Controller implements UserController {
  final UserRepository userRepository;

  UserControllerImpl({required this.userRepository}) : super(InitialState());

  @override
  Future<void> getAllUsers() async {
    emitState(LoadingState());
    final result = await userRepository.findAllUsers();
    final AppState<List<UserModel>> users = switch (result) {
      Success(value: final users) => SuccessState(data: users),
      Error(error: final exception) => ErrorState(
        message: 'Something went wrong: $exception',
      ),
    };
    emitState(users);
    _debug();
  }

  void _debug() {
    debugPrint('User state: $state');
  }
}

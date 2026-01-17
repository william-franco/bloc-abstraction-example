import 'package:bloc_abstraction_example/src/common/state_management/state_management.dart';
import 'package:bloc_abstraction_example/src/common/states/state.dart';
import 'package:bloc_abstraction_example/src/features/users/models/user_model.dart';
import 'package:bloc_abstraction_example/src/features/users/repositories/user_repository.dart';
import 'package:flutter/material.dart';

typedef _ViewModel = StateManagement<AppState<List<UserModel>>>;

typedef UsersState = AppState<List<UserModel>>;

abstract interface class UserViewModel extends _ViewModel {
  UserViewModel(super.initialState);

  Future<void> getAllUsers();
}

class UserViewModelImpl extends _ViewModel implements UserViewModel {
  final UserRepository userRepository;

  UserViewModelImpl({required this.userRepository}) : super(InitialState());

  @override
  Future<void> getAllUsers() async {
    emitState(LoadingState());
    final result = await userRepository.findAllUsers();

    final state = result.fold<UsersState>(
      onSuccess: (value) => SuccessState(data: value),
      onError: (error) => ErrorState(message: '$error'),
    );

    emitState(state);
    _debug();
  }

  void _debug() {
    debugPrint('User state: $state');
  }
}

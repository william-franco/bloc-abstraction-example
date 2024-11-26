import 'package:bloc_abstraction_example/src/features/users/models/user_model.dart';

sealed class UserState {}

final class UserInitialState extends UserState {}

final class UserLoadingState extends UserState {}

final class UserSuccessState extends UserState {
  final List<UserModel> users;

  UserSuccessState({
    required this.users,
  });
}

final class UserErrorState extends UserState {
  final String message;

  UserErrorState({
    required this.message,
  });
}

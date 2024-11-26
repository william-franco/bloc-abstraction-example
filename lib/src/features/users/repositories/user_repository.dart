import 'package:bloc_abstraction_example/src/common/environments/environments.dart';
import 'package:bloc_abstraction_example/src/common/exception_handlings/exception_handling.dart';
import 'package:bloc_abstraction_example/src/common/services/http_service.dart';
import 'package:bloc_abstraction_example/src/features/users/models/user_model.dart';

abstract interface class UserRepository {
  Future<Result<UserModel, Exception>> findUserById(String id);
  Future<Result<List<UserModel>, Exception>> findAllUsers();
}

class UserRepositoryImpl implements UserRepository {
  final HttpService httpService;

  UserRepositoryImpl({
    required this.httpService,
  });

  @override
  Future<Result<UserModel, Exception>> findUserById(String id) async {
    try {
      final response = await httpService.getData(
        path: '${Environments.users}$id',
      );
      switch (response.statusCode) {
        case 200:
          final success = UserModel.fromJson(response.data);
          return Success(value: success);
        default:
          return Error(error: Exception(response.statusMessage));
      }
    } on Exception catch (error) {
      return Error(error: error);
    }
  }

  @override
  Future<Result<List<UserModel>, Exception>> findAllUsers() async {
    try {
      final response = await httpService.getData(
        path: Environments.users,
      );
      switch (response.statusCode) {
        case 200:
          final success = (response.data as List)
              .map((e) => UserModel.fromJson(e))
              .toList();
          return Success(value: success);
        default:
          return Error(error: Exception(response.statusMessage));
      }
    } on Exception catch (error) {
      return Error(error: error);
    }
  }
}

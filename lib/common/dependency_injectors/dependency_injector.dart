import 'package:bloc_abstraction_example/common/services/http_service.dart';
import 'package:bloc_abstraction_example/features/users/controllers/user_controller.dart';
import 'package:bloc_abstraction_example/features/users/repositories/user_repository.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void dependencyInjector() {
  _startFeatureUser();
}

void _startFeatureUser() {
  locator.registerCachedFactory<HttpService>(
    () => HttpServiceImpl(),
  );
  locator.registerCachedFactory<UserRepository>(
    () => UserRepositoryImpl(
      httpService: locator<HttpService>(),
    ),
  );
  locator.registerCachedFactory<UserController>(
    () => UserControllerImpl(
      userRepository: locator<UserRepository>(),
    ),
  );
}

void resetDependencies() {
  locator.reset();
}

void resetUserController() {
  locator.unregister<UserController>();
  _startFeatureUser();
}

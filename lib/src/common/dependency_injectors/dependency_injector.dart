import 'package:bloc_abstraction_example/src/common/services/http_service.dart';
import 'package:bloc_abstraction_example/src/common/services/storage_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void dependencyInjector() {
  _startFeatureUser();
  _startFeatureSetting();
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

void _startFeatureSetting() {
  locator.registerCachedFactory<StorageService>(
    () => StorageServiceImpl(),
  );
  locator.registerCachedFactory<SettingRepository>(
    () => SettingRepositoryImpl(
      storageService: locator<StorageService>(),
    ),
  );
  locator.registerCachedFactory<SettingController>(
    () => SettingControllerImpl(
      settingRepository: locator<SettingRepository>(),
    ),
  );
}

void resetDependencies() {
  locator.reset();
}

void resetFeatureUser() {
  locator.unregister<UserRepository>();
  locator.unregister<UserController>();
  _startFeatureUser();
}
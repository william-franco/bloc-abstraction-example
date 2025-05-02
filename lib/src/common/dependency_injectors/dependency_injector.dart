import 'package:bloc_abstraction_example/src/common/services/http_service.dart';
import 'package:bloc_abstraction_example/src/common/services/storage_service.dart';
import 'package:bloc_abstraction_example/src/features/settings/controllers/setting_controller.dart';
import 'package:bloc_abstraction_example/src/features/settings/repositories/setting_repository.dart';
import 'package:bloc_abstraction_example/src/features/users/controllers/user_controller.dart';
import 'package:bloc_abstraction_example/src/features/users/repositories/user_repository.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void dependencyInjector() {
  _startStorageService();
  _startHttpService();
  _startFeatureUser();
  _startFeatureSetting();
}

void _startStorageService() {
  locator.registerLazySingleton<StorageService>(() => StorageServiceImpl());
}

void _startHttpService() {
  locator.registerLazySingleton<HttpService>(() => HttpServiceImpl());
}

void _startFeatureUser() {
  locator.registerCachedFactory<UserRepository>(
    () => UserRepositoryImpl(httpService: locator<HttpService>()),
  );
  locator.registerCachedFactory<UserController>(
    () => UserControllerImpl(userRepository: locator<UserRepository>()),
  );
}

void _startFeatureSetting() {
  locator.registerCachedFactory<SettingRepository>(
    () => SettingRepositoryImpl(storageService: locator<StorageService>()),
  );
  locator.registerCachedFactory<SettingController>(
    () =>
        SettingControllerImpl(settingRepository: locator<SettingRepository>()),
  );
}

Future<void> initDependencies() async {
  await locator<StorageService>().initStorage();
  await Future.wait([locator<SettingController>().loadTheme()]);
}

void resetDependencies() {
  locator.reset();
}

void resetFeatureSetting() {
  locator.unregister<SettingRepository>();
  locator.unregister<SettingController>();
  _startFeatureSetting();
}

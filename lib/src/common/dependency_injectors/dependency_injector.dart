import 'package:bloc_abstraction_example/src/common/services/connection_service.dart';
import 'package:bloc_abstraction_example/src/common/services/http_service.dart';
import 'package:bloc_abstraction_example/src/common/services/storage_service.dart';
import 'package:bloc_abstraction_example/src/features/settings/view_models/setting_view_model.dart';
import 'package:bloc_abstraction_example/src/features/settings/repositories/setting_repository.dart';
import 'package:bloc_abstraction_example/src/features/users/view_models/user_view_model.dart';
import 'package:bloc_abstraction_example/src/features/users/repositories/user_repository.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void dependencyInjector() {
  _startConnectionService();
  _startHttpService();
  _startStorageService();
  _startFeatureUser();
  _startFeatureSetting();
}

void _startConnectionService() {
  locator.registerLazySingleton<ConnectionService>(
    () => ConnectionServiceImpl(),
  );
}

void _startStorageService() {
  locator.registerLazySingleton<StorageService>(() => StorageServiceImpl());
}

void _startHttpService() {
  locator.registerLazySingleton<HttpService>(() => HttpServiceImpl());
}

void _startFeatureUser() {
  locator.registerCachedFactory<UserRepository>(
    () => UserRepositoryImpl(
      connectionService: locator<ConnectionService>(),
      httpService: locator<HttpService>(),
    ),
  );
  locator.registerLazySingleton<UserViewModel>(
    () => UserViewModelImpl(userRepository: locator<UserRepository>()),
  );
}

void _startFeatureSetting() {
  locator.registerCachedFactory<SettingRepository>(
    () => SettingRepositoryImpl(storageService: locator<StorageService>()),
  );
  locator.registerLazySingleton<SettingViewModel>(
    () => SettingViewModelImpl(settingRepository: locator<SettingRepository>()),
  );
}

Future<void> initDependencies() async {
  await locator<StorageService>().initStorage();
  await Future.wait([locator<SettingViewModel>().getTheme()]);
}

void resetDependencies() {
  locator.reset();
}

void resetFeatureSetting() {
  locator.unregister<SettingRepository>();
  locator.unregister<SettingViewModel>();
  _startFeatureSetting();
}

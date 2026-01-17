import 'package:bloc_abstraction_example/src/common/dependency_injectors/dependency_injector.dart';
import 'package:bloc_abstraction_example/src/common/routes/routes.dart';
import 'package:bloc_abstraction_example/src/common/state_management/state_management.dart';
import 'package:bloc_abstraction_example/src/features/settings/view_models/setting_view_model.dart';
import 'package:bloc_abstraction_example/src/features/settings/models/setting_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  dependencyInjector();
  await initDependencies();
  final Routes appRoutes = Routes();
  runApp(
    MyApp(appRoutes: appRoutes, settingViewModel: locator<SettingViewModel>()),
  );
}

class MyApp extends StatelessWidget {
  final Routes appRoutes;
  final SettingViewModel settingViewModel;

  const MyApp({
    super.key,
    required this.appRoutes,
    required this.settingViewModel,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StateBuilderWidget<SettingViewModel, SettingModel>(
      viewModel: settingViewModel,
      builder: (context, settingModel) {
        return MaterialApp.router(
          title: 'Bloc Abstraction Example',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(useMaterial3: true),
          darkTheme: ThemeData.dark(useMaterial3: true),
          themeMode: settingModel.isDarkTheme
              ? ThemeMode.dark
              : ThemeMode.light,
          routerConfig: appRoutes.routes,
        );
      },
    );
  }
}

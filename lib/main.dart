import 'package:bloc_abstraction_example/src/common/dependency_injectors/dependency_injector.dart';
import 'package:bloc_abstraction_example/src/common/routes/routes.dart';
import 'package:bloc_abstraction_example/src/common/widgets/state_builder_widget.dart';
import 'package:bloc_abstraction_example/src/features/settings/controllers/setting_controller.dart';
import 'package:bloc_abstraction_example/src/features/settings/models/setting_model.dart';
import 'package:flutter/material.dart';

void main() {
  dependencyInjector();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StateBuilderWidget<SettingController, SettingModel>(
      controller: locator<SettingController>(),
      builder: (context, value) {
        return MaterialApp.router(
          title: 'Bloc Abstraction Example',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(
            useMaterial3: true,
          ),
          darkTheme: ThemeData.dark(
            useMaterial3: true,
          ),
          themeMode: value.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
          routerConfig: Routes.routes,
        );
      },
    );
  }
}

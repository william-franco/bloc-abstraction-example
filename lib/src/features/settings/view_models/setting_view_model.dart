import 'package:bloc_abstraction_example/src/common/controllers/state_controller.dart';
import 'package:bloc_abstraction_example/src/features/settings/models/setting_model.dart';
import 'package:bloc_abstraction_example/src/features/settings/repositories/setting_repository.dart';
import 'package:flutter/material.dart';

typedef _ViewModel = StateController<SettingModel>;

abstract interface class SettingViewModel extends _ViewModel {
  SettingViewModel() : super(SettingModel());

  Future<void> getTheme();
  Future<void> changeTheme({required bool isDarkTheme});
}

class SettingViewModelImpl extends _ViewModel implements SettingViewModel {
  final SettingRepository settingRepository;

  SettingViewModelImpl({required this.settingRepository})
    : super(SettingModel());

  @override
  Future<void> getTheme() async {
    final model = await settingRepository.readTheme();
    emitState(model);
    _debug();
  }

  @override
  Future<void> changeTheme({required bool isDarkTheme}) async {
    final model = state.copyWith(isDarkTheme: isDarkTheme);
    await settingRepository.updateTheme(isDarkTheme: isDarkTheme);
    emitState(model);
    _debug();
  }

  void _debug() {
    debugPrint('Dark theme: ${state.isDarkTheme}');
  }
}

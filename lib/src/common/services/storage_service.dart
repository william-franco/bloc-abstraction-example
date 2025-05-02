import 'package:shared_preferences/shared_preferences.dart';

abstract interface class StorageService {
  Future<void> initStorage();

  Future<bool> getBoolValue({required String key});
  Future<void> setBoolValue({required String key, required bool value});
}

class StorageServiceImpl implements StorageService {
  late final SharedPreferences _storage;

  @override
  Future<void> initStorage() async {
    try {
      _storage = await SharedPreferences.getInstance();
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<bool> getBoolValue({required String key}) async {
    try {
      bool value = _storage.getBool(key) ?? false;
      return value;
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> setBoolValue({required String key, required bool value}) async {
    try {
      await _storage.setBool(key, value);
    } catch (error) {
      throw Exception(error);
    }
  }
}

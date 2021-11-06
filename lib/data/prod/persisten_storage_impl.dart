import 'package:clean_architecture_streamchat/data/persisten_storage_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersistenStorageImpl extends PersistenStorageRepository {
  static const _isDarkMode = 'isDarkMode';

  @override
  Future<bool> isDarkMode() async {
    final preference = await SharedPreferences.getInstance();
    return preference.getBool(_isDarkMode) ?? false;
  }

  @override
  Future<void> updateDarkMode({required bool isDarkMode}) async {
    final preference = await SharedPreferences.getInstance();
    await preference.setBool(_isDarkMode, isDarkMode);
    return;
  }
}

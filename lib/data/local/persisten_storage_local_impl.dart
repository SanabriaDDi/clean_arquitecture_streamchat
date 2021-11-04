import 'package:clean_architecture_streamchat/data/persisten_storage_repository.dart';

class PersistenStorageLocalImpl extends PersistenStorageRepository {
  @override
  Future<bool> isDarkMode() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return false;
  }

  @override
  Future<void> updateDarkMode({required bool isDarkMode}) async {
    await Future.delayed(const Duration(milliseconds: 50));
    return;
  }
}

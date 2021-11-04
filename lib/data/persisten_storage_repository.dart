abstract class PersistenStorageRepository {
  Future<bool> isDarkMode();

  Future<void> updateDarkMode({required bool isDarkMode});
}

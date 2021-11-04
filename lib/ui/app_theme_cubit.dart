import 'package:bloc/bloc.dart';
import 'package:clean_architecture_streamchat/data/persisten_storage_repository.dart';

class AppThemeCubit extends Cubit<bool> {
  final PersistenStorageRepository _persistenStorageRepository;

  AppThemeCubit(
      {required PersistenStorageRepository persistenStorageRepository})
      : _persistenStorageRepository = persistenStorageRepository,
        super(false);

  bool _isDark = false;

  bool get isDark => _isDark;

  Future<void> init() async {
    _isDark = await _persistenStorageRepository.isDarkMode();
    emit(_isDark);
  }

  Future<void> updateTheme(bool isDarkMode) async {
    _isDark = isDarkMode;
    await _persistenStorageRepository.updateDarkMode(isDarkMode: isDarkMode);
    emit(_isDark);
  }
}

import 'package:bloc/bloc.dart';

class AppThemeCubit extends Cubit<bool> {
  AppThemeCubit() : super(false);

  bool _isDark = false;
  bool get isDark => _isDark;

  Future<void> init() async {
    //TODO: verify local storage
    _isDark = true;
    emit(_isDark);
  }
}

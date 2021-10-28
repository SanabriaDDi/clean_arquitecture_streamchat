import 'package:flutter_bloc/flutter_bloc.dart';

enum SplashState {
  none,
  existingUser,
  newUser,
}

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState.none);

  void init() async {
    //TODO: validate with services
    await Future.delayed(const Duration(seconds: 2));
    emit(SplashState.none);
  }

}
import 'package:clean_architecture_streamchat/domain/exceptions/auth_exceptions.dart';
import 'package:clean_architecture_streamchat/domain/usecases/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SplashState {
  none,
  existingUser,
  newUser,
}

class SplashCubit extends Cubit<SplashState> {
  final LoginUseCase _loginUseCase;

  SplashCubit({required LoginUseCase loginUseCase})
      : _loginUseCase = loginUseCase,
        super(SplashState.none);

  void init() async {
    try {
      final result = await _loginUseCase.validateLogin();
      if(result) {
        emit(SplashState.existingUser);
      }
    } on AuthException catch (e) {
      if(e.error == AuthErrorCode.notAuth){
        emit(SplashState.none);
      } else {
        emit(SplashState.newUser);
      }
    }
  }
}

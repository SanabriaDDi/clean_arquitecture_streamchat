import 'package:clean_architecture_streamchat/domain/usecases/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SignInState {
  none,
  existingUser,
}

class SignInCubit extends Cubit<SignInState> {
  final LoginUseCase _loginUseCase;

  SignInCubit({required LoginUseCase loginUseCase})
      : _loginUseCase = loginUseCase,
        super(SignInState.none);

  void signIn() async {
    try {
      final result = await _loginUseCase.validateLogin();
      if (result) {
        emit(SignInState.existingUser);
      }
    } catch (_) {
      final result = await _loginUseCase.signIn();
      if(result != null) {
        emit(SignInState.none);
      }
    }
  }
}

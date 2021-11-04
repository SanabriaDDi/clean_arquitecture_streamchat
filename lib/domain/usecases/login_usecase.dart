import 'package:clean_architecture_streamchat/data/auth_repository.dart';
import 'package:clean_architecture_streamchat/data/stream_api_repository.dart';
import 'package:clean_architecture_streamchat/domain/exceptions/auth_exceptions.dart';

class LoginUseCase {
  final AuthRepository authRepository;
  final StreamApiRepository streamApiRepository;

  LoginUseCase(this.authRepository, this.streamApiRepository);

  Future<bool> validateLogin() async {
    final user = await authRepository.getAuthUser();
    if(user != null ) {
      final result = await streamApiRepository.connectIfExists(userId: user.id);
      if(result) {
        return true;
      } else {
        throw AuthException(AuthErrorCode.notChatUser);
      }
    }
    throw AuthException(AuthErrorCode.notAuth);;
  }
}

import 'package:clean_architecture_streamchat/data/auth_repository.dart';
import 'package:clean_architecture_streamchat/data/stream_api_repository.dart';

class LogoutUseCase {
  final StreamApiRepository streamApiRepository;
  final AuthRepository authRepository;

  LogoutUseCase(this.streamApiRepository, this.authRepository);

  Future<void> logout() async {
    await streamApiRepository.logout();
    await authRepository.logout();
  }
}
import 'package:clean_architecture_streamchat/data/auth_repository.dart';
import 'package:clean_architecture_streamchat/domain/models/auth_user.dart';

class AuthLocalImpl extends AuthRepository {
  @override
  Future<AuthUser?> getAuthUser() async {
    await Future.delayed(const Duration(seconds: 2));
    return AuthUser('diego');
  }

  @override
  Future<AuthUser> signIn() async {
    await Future.delayed(const Duration(seconds: 2));
    return AuthUser('diego');
  }

  @override
  Future<void> logout() async {
    return;
  }


}

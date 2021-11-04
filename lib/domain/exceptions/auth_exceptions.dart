enum AuthErrorCode { notAuth, notChatUser }

class AuthException implements Exception {
  final AuthErrorCode error;

  AuthException(this.error);
}

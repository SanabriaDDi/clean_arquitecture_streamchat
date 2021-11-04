import 'dart:io';

import 'package:clean_architecture_streamchat/data/auth_repository.dart';
import 'package:clean_architecture_streamchat/data/stream_api_repository.dart';
import 'package:clean_architecture_streamchat/data/upload_storage_repository.dart';
import 'package:clean_architecture_streamchat/domain/models/chat_user.dart';

class ProfileInput {
  final File? imageFile;
  final String name;

  ProfileInput({this.imageFile, required this.name});
}

class ProfileSignInUseCase {
  final AuthRepository _authRepository;
  final UploadStorageRepository _uploadStorageRepository;
  final StreamApiRepository _streamApiRepository;

  ProfileSignInUseCase(this._authRepository, this._uploadStorageRepository,
      this._streamApiRepository);

  Future<void> verify(ProfileInput input) async {
    final auth = await _authRepository.getAuthUser();
    final token = await _streamApiRepository.getToken(userId: auth!.id);
    String? image;
    if (input.imageFile != null) {
      image = await _uploadStorageRepository.uploadPhoto(
          file: input.imageFile!, path: 'users/${auth.id}');
    }

    await _streamApiRepository.connectUser(
        user: ChatUser(name: input.name, id: auth.id, image: image),
        token: token);
  }
}

import 'dart:io';

import 'package:clean_architecture_streamchat/data/stream_api_repository.dart';
import 'package:clean_architecture_streamchat/data/upload_storage_repository.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:uuid/uuid.dart';

class CreateGroupInput {
  final File? imageFile;
  final String name;
  final List<String> members;

  CreateGroupInput(
      {required this.imageFile, required this.name, required this.members});
}

class CreateGroupUseCase {
  final UploadStorageRepository _uploadStorageRepository;
  final StreamApiRepository _streamApiRepository;

  CreateGroupUseCase(this._uploadStorageRepository, this._streamApiRepository);

  Future<Channel> createGroup(CreateGroupInput input) async {
    final channelId = const Uuid().v4();
    String? image;
    if(input.imageFile != null) {
      image = await _uploadStorageRepository.uploadPhoto(
          file: input.imageFile!, path: 'channels/$channelId');
    }

    final channel = await _streamApiRepository.createGroupChat(
      channelId: channelId,
      name: input.name,
      members: input.members,
      image: image,
    );
    return channel;
  }
}

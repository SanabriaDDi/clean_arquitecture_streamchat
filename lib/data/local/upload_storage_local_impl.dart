import 'dart:io';

import 'package:clean_architecture_streamchat/data/upload_storage_repository.dart';

class UploadStorageLocalImpl extends UploadStorageRepository {
  @override
  Future<String> uploadPhoto({required File file, required String path}) async {
    return 'https://lh3.googleusercontent.com/a-/AOh14Ggs0tRl1UYQSn2kj4-HMLHezAS4UB7rjKqVSU8s3g=s288-p-rw-no';
  }
}

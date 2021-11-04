import 'dart:io';

abstract class UploadStorageRepository {
  Future<String> uploadPhoto({required File file, required String path});
}
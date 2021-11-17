import 'dart:io';

import 'package:clean_architecture_streamchat/data/image_picker_repository.dart';
import 'package:clean_architecture_streamchat/domain/usecases/profile_sign_in_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileState {
  final File? file;
  final bool success;
  final bool isLoading;

  const ProfileState(this.file, {this.success = false, this.isLoading = false});
}

class ProfileVerifyCubit extends Cubit<ProfileState> {
  ProfileVerifyCubit(
      {required ImagePickerRepository imagePickerRepository,
      required ProfileSignInUseCase profileSignInUseCase})
      : _imagePickerRepository = imagePickerRepository,
        _profileSignInUseCase = profileSignInUseCase,
        super(const ProfileState(null));

  final nameController = TextEditingController();
  final ImagePickerRepository _imagePickerRepository;
  final ProfileSignInUseCase _profileSignInUseCase;

  void startChatting() async {
    emit(const ProfileState(null, isLoading: true));
    final file = state.file;
    final name = nameController.text;

    await _profileSignInUseCase
        .verify(ProfileInput(imageFile: file, name: name));

    emit(ProfileState(file, success: true, isLoading: false));
  }

  void pickImage() async {
    final file = await _imagePickerRepository.pickImage();
    emit(ProfileState(file));
  }
}

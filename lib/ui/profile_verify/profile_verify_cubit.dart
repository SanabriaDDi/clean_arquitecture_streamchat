import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileState {
  final File? file;
  final bool success;

  const ProfileState(this.file, {this.success = false});
}

class ProfileVerifyCubit extends Cubit<ProfileState> {
  ProfileVerifyCubit() : super(const ProfileState(null));

  final nameController = TextEditingController();

  void startChatting() async {
    //TODO: call services
    await Future.delayed(const Duration(seconds: 2));
    final file = state.file;
    final name = nameController.text;
    emit(ProfileState(file, success: true));
  }

  void pickImage() {
    //TODO: call services
    final file = File('');
    emit(ProfileState(file));
  }
}

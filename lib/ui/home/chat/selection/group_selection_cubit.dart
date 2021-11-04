import 'dart:io';

import 'package:clean_architecture_streamchat/data/image_picker_repository.dart';
import 'package:clean_architecture_streamchat/domain/usecases/create_group_use_case.dart';
import 'package:clean_architecture_streamchat/ui/home/chat/selection/friends_selection_cubit.dart';
import 'package:flutter/material.dart' show TextEditingController;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class GroupSelectionState {
  final File? file;
  final Channel? channel;

  GroupSelectionState(this.file, {this.channel});
}

class GroupSelectionCubit extends Cubit<GroupSelectionState?> {
  final nameTextController = TextEditingController();
  final List<ChatUserState> _members;
  final CreateGroupUseCase _createGroupUseCase;
  final ImagePickerRepository _imagePickerRepository;

  GroupSelectionCubit(
      {required List<ChatUserState> members,
      required CreateGroupUseCase createGroupUseCase,
      required ImagePickerRepository imagePickerRepository})
      : _members = members,
        _createGroupUseCase = createGroupUseCase,
        _imagePickerRepository = imagePickerRepository,
        super(null);

  void createGroup() async {
    final channel = await _createGroupUseCase.createGroup(CreateGroupInput(
        imageFile: state!.file!,
        name: nameTextController.text,
        members: _members.map((e) => e.chatUser.id).toList()));
    emit(GroupSelectionState(state!.file, channel: channel));
  }

  void pickImage() async {
    final image = await _imagePickerRepository.pickImage();
    emit(GroupSelectionState(image));
  }
}

import 'dart:io';

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
  final List<ChatUserState> members;

  GroupSelectionCubit({required this.members}) : super(null);

  void createGroup() async {
    //TODO: create channel
    emit(GroupSelectionState(state!.file, channel: null));
  }

  void pickImage() async {
    //TODO: pick image
    emit(GroupSelectionState(null));
  }

}

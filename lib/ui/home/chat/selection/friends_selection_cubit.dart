import 'package:clean_architecture_streamchat/domain/models/chat_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatUserState {
  final ChatUser chatUser;
  final bool selected;

  ChatUserState({required this.chatUser, this.selected = false});
}

class FriendsSelectionCubit extends Cubit<List<ChatUserState>> {
  FriendsSelectionCubit() : super([]);

  List<ChatUserState> get selectedUsers =>
      state.where((element) => element.selected).toList();

  Future<void> init() async {
    //TODO: call services

    final list = List.generate(
      10,
      (index) => ChatUserState(
        chatUser: ChatUser(
          id: '$index',
          name: 'Item :$index',
        ),
      ),
    );
    emit(list);
  }

  void selectedUser(ChatUserState chatUser) {
    final index = state
        .indexWhere((element) => element.chatUser.id == chatUser.chatUser.id);
    state[index] = ChatUserState(chatUser: state[index].chatUser, selected: !chatUser.selected);
    emit(List<ChatUserState>.from(state));
  }

  Future<Channel?> createFriendChannel(ChatUserState chatUserState) async {
    //TODO: call services

  }
}

class FriendsGroupCubit extends Cubit<bool> {
  FriendsGroupCubit() : super(false);

  void changeToGroup() =>  emit(!state);

}

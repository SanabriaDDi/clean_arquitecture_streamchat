import 'package:clean_architecture_streamchat/navigator_utils.dart';
import 'package:clean_architecture_streamchat/ui/common/avatar_image_view.dart';
import 'package:clean_architecture_streamchat/ui/home/chat/chat_view.dart';
import 'package:clean_architecture_streamchat/ui/home/chat/selection/friends_selection_cubit.dart';
import 'package:clean_architecture_streamchat/ui/home/chat/selection/group_selection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class GroupSelectionView extends StatelessWidget {
  const GroupSelectionView(this.selectedUsers, {Key? key}) : super(key: key);

  final List<ChatUserState> selectedUsers;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroupSelectionCubit(
        members: selectedUsers,
        imagePickerRepository: context.read(),
        createGroupUseCase: context.read(),
      ),
      child: BlocConsumer<GroupSelectionCubit, GroupSelectionState?>(
        listener: (context, state) {
          if (state!.channel != null) {
            pushAndReplaceToPage(
                context,
                Scaffold(
                  body: StreamChannel(
                      channel: state.channel!, child: const ChannelPage()),
                ));
          }
        },
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.arrow_right_alt_rounded),
              onPressed: context.read<GroupSelectionCubit>().createGroup,
            ),
            backgroundColor: Theme.of(context).canvasColor,
            appBar: AppBar(
              title: Text(
                'New Group',
                style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
              centerTitle: false,
              elevation: 0,
              backgroundColor: Theme.of(context).canvasColor,
              leading: BackButton(
                color: Theme.of(context).appBarTheme.backgroundColor,
              ),
            ),
            body: Center(
              child: Column(
                children: [
                  AvatartImageView(
                    onTap: context.read<GroupSelectionCubit>().pickImage,
                    child: state?.file != null
                        ? Image.file(
                            state!.file!,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.person_outline,
                            size: 100,
                            color: Colors.grey[400],
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    child: TextField(
                      controller: context
                          .read<GroupSelectionCubit>()
                          .nameTextController,
                      decoration: InputDecoration(
                        fillColor: Theme.of(context)
                            .bottomNavigationBarTheme
                            .backgroundColor,
                        hintText: 'Name of the group',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[400],
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Wrap(
                    children: List.generate(selectedUsers.length, (index) {
                      final chatUserState = selectedUsers[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: chatUserState.chatUser.image !=
                                      null
                                  ? NetworkImage(chatUserState.chatUser.image!)
                                  : null,
                            ),
                            Text(selectedUsers[index].chatUser.name),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

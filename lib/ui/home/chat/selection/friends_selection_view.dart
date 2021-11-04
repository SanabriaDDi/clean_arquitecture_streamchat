import 'package:clean_architecture_streamchat/navigator_utils.dart';
import 'package:clean_architecture_streamchat/ui/home/chat/chat_view.dart';
import 'package:clean_architecture_streamchat/ui/home/chat/selection/friends_selection_cubit.dart';
import 'package:clean_architecture_streamchat/ui/home/chat/selection/group_selection_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class FriendsSelectionView extends StatelessWidget {
  const FriendsSelectionView({Key? key}) : super(key: key);

  void _createFriendChannel(
      BuildContext context, ChatUserState chatUserState) async {
    final channel = await context
        .read<FriendsSelectionCubit>()
        .createFriendChannel(chatUserState);
    pushAndReplaceToPage(
        context,
        Scaffold(
          body: StreamChannel(channel: channel, child: const ChannelPage()),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                FriendsSelectionCubit(streamApiRepository: context.read())
                  ..init()),
        BlocProvider(create: (_) => FriendsGroupCubit()),
      ],
      child: BlocBuilder<FriendsGroupCubit, bool>(
        builder: (context, isGroup) {
          return BlocBuilder<FriendsSelectionCubit, List<ChatUserState>>(
            builder: (context, state) {
              final selectedUsers =
                  context.read<FriendsSelectionCubit>().selectedUsers;

              return Scaffold(
                floatingActionButton: isGroup && selectedUsers.isNotEmpty
                    ? FloatingActionButton(onPressed: () {
                        pushAndReplaceToPage(
                            context, GroupSelectionView(selectedUsers));
                      })
                    : null,
                body: Column(
                  children: [
                    if (isGroup)
                      Row(children: [
                        BackButton(onPressed: () {
                          context.read<FriendsGroupCubit>().changeToGroup();
                        }),
                        const Text('New group'),
                      ])
                    else
                      Row(children: [
                        BackButton(
                          onPressed: Navigator.of(context).pop,
                        ),
                        const Text('People'),
                      ]),
                    if (!isGroup)
                      ElevatedButton(
                        child: const Text('Create group'),
                        onPressed: () {
                          context.read<FriendsGroupCubit>().changeToGroup();
                        },
                      )
                    else if (isGroup && selectedUsers.isEmpty)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          CircleAvatar(),
                          Text('Add a friend'),
                        ],
                      )
                    else
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: selectedUsers.length,
                          itemBuilder: (context, index) {
                            final chatUserState = selectedUsers[index];
                            return Stack(
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const CircleAvatar(),
                                    Text(chatUserState.chatUser.name)
                                  ],
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    context
                                        .read<FriendsSelectionCubit>()
                                        .selectedUser(chatUserState);
                                  },
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.length,
                        itemBuilder: (context, index) {
                          final chatUserState = state[index];
                          return ListTile(
                            onTap: () {
                              _createFriendChannel(context, chatUserState);
                            },
                            leading: CircleAvatar(
                              backgroundImage: chatUserState.chatUser.image !=
                                      null
                                  ? NetworkImage(chatUserState.chatUser.image!)
                                  : null,
                            ),
                            title: Text(chatUserState.chatUser.name),
                            trailing: isGroup
                                ? Checkbox(
                                    value: chatUserState.selected,
                                    onChanged: (val) {
                                      print('select user for a group');
                                      context
                                          .read<FriendsSelectionCubit>()
                                          .selectedUser(chatUserState);
                                    },
                                  )
                                : null,
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:clean_architecture_streamchat/navigator_utils.dart';
import 'package:clean_architecture_streamchat/ui/home/chat/selection/friends_selection_cubit.dart';
import 'package:clean_architecture_streamchat/ui/home/chat/selection/group_selection_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendsSelectionView extends StatelessWidget {
  const FriendsSelectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => FriendsSelectionCubit()..init()),
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
                      pushAndReplaceToPage(context, GroupSelectionView(selectedUsers));
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
                              print('select user');
                            },
                            leading: const CircleAvatar(),
                            title: Text('user $index'),
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

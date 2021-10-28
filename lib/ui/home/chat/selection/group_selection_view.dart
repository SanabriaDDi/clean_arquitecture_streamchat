import 'package:clean_architecture_streamchat/ui/home/chat/selection/friends_selection_cubit.dart';
import 'package:clean_architecture_streamchat/ui/home/chat/selection/group_selection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupSelectionView extends StatelessWidget {
  const GroupSelectionView(this.selectedUsers, {Key? key}) : super(key: key);

  final List<ChatUserState> selectedUsers;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroupSelectionCubit(members: selectedUsers),
      child: BlocConsumer<GroupSelectionCubit, GroupSelectionState?>(
        listener: (context, state) {
          //TODO: call chat view
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Verify your identity'),
                  const Placeholder(
                    fallbackHeight: 100,
                    fallbackWidth: 100,
                  ),
                  IconButton(
                    icon: const Icon(Icons.photo),
                    onPressed: () {},
                  ),
                  TextField(
                    controller:
                        context.read<GroupSelectionCubit>().nameTextController,
                    decoration:
                        const InputDecoration(hintText: 'Name of the group'),
                  ),
                  Wrap(
                    children: List.generate(
                      selectedUsers.length,
                      (index) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircleAvatar(),
                          Text(selectedUsers[index].chatUser.name),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: const Text('Next'),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FriendsSelectionView extends StatelessWidget {
  const FriendsSelectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isGroup = true;
    final selectedUsers = /*<ChatUser>*/[];
    return Scaffold(
      floatingActionButton: isGroup && selectedUsers.isNotEmpty
          ? FloatingActionButton(onPressed: () {
              print('Display group');
            })
          : null,
      body: Column(
        children: [
          if (isGroup)
            Row(children: [
              BackButton(onPressed: () {
                print('change to group');
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
                print('create group');
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
                          Text(chatUserState.name)
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          print('select user');
                        },
                      )
                    ],
                  );
                },
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    print('select user');
                  },
                  leading: const CircleAvatar(),
                  title: Text('user $index'),
                  trailing: isGroup
                      ? Checkbox(
                          value: false,
                          onChanged: (val) {
                            print('select user for a group');
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
  }
}

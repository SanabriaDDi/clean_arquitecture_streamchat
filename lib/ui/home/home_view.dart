import 'package:clean_architecture_streamchat/navigator_utils.dart';
import 'package:clean_architecture_streamchat/ui/home/settings/settings_view.dart';
import 'package:flutter/material.dart';

import 'chat/chat_view.dart';
import 'chat/selection/friends_selection_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: IndexedStack(
            index: 1,
            children: const [
              ChatView(),
              SettingsView(),
            ],
          ),
        ),
        const HomeNavigationBar()
      ],
    );
  }
}

class HomeNavigationBar extends StatelessWidget {
  const HomeNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: const Text('Chats'),
            onPressed: () {},
          ),
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              pushToPage(context, const FriendsSelectionView());
            },
          ),
          ElevatedButton(
            child: const Text('Settings'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

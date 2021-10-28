import 'package:clean_architecture_streamchat/navigator_utils.dart';
import 'package:clean_architecture_streamchat/ui/home/home_cubit.dart';
import 'package:clean_architecture_streamchat/ui/home/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat/chat_view.dart';
import 'chat/selection/friends_selection_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<HomeCubit, int>(
              builder: (context, state) {
                return IndexedStack(
                  index: state,
                  children: const [
                    ChatView(),
                    SettingsView(),
                  ],
                );
              },
            ),
          ),
          const HomeNavigationBar()
        ],
      ),
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
            onPressed: () {
              context.read<HomeCubit>().onChangeTab(0);
            },
          ),
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              pushToPage(context, const FriendsSelectionView());
            },
          ),
          ElevatedButton(
            child: const Text('Settings'),
            onPressed: () {
              context.read<HomeCubit>().onChangeTab(1);
            },
          ),
        ],
      ),
    );
  }
}

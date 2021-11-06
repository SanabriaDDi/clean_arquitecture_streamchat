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
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: BlocProvider(
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
      ),
    );
  }
}

class HomeNavigationBar extends StatelessWidget {
  const HomeNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const navigationBarSize = 80.0;
    const buttonSize = 56.0;
    const buttonMargin = 4.0;
    const topMargin = buttonSize / 2 + buttonMargin / 2;
    final canvasColor = Theme.of(context).canvasColor;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Material(
        child: Container(
          height: navigationBarSize + topMargin,
          width: MediaQuery.of(context).size.width * 0.7,
          color: canvasColor,
          child: Stack(
            children: [
              Positioned.fill(
                top: topMargin,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context)
                        .bottomNavigationBarTheme
                        .backgroundColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _HomeNavItem(
                        text: 'Chats',
                        iconData: Icons.chat_bubble,
                        onTap: () => context.read<HomeCubit>().onChangeTab(0),
                        selected:
                            context.select((HomeCubit bloc) => bloc.state == 0),
                      ),
                      _HomeNavItem(
                        text: 'Settings',
                        iconData: Icons.settings,
                        onTap: () => context.read<HomeCubit>().onChangeTab(1),
                        selected:
                            context.select((HomeCubit bloc) => bloc.state == 1),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                    color: canvasColor,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(buttonMargin / 2),
                  child: FloatingActionButton(
                    onPressed: () {
                      pushToPage(context, const FriendsSelectionView());
                    },
                    child: const Icon(Icons.add),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeNavItem extends StatelessWidget {
  final IconData iconData;
  final String text;
  final VoidCallback onTap;
  final bool selected;

  const _HomeNavItem({
    Key? key,
    required this.iconData,
    required this.text,
    required this.onTap,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedColor =
        Theme.of(context).bottomNavigationBarTheme.selectedItemColor;
    final unselectedColor =
        Theme.of(context).bottomNavigationBarTheme.unselectedItemColor;
    final color = selected ? selectedColor : unselectedColor;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconData, color: color),
          Text(text, style: TextStyle(color: color),),
        ],
      ),
    );
  }
}

import 'package:clean_architecture_streamchat/navigator_utils.dart';
import 'package:clean_architecture_streamchat/ui/home/home_view.dart';
import 'package:flutter/material.dart';

class ProfileVeifyView extends StatelessWidget {
  const ProfileVeifyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            const Text('Your name'),
            const TextField(
              decoration: InputDecoration(hintText: 'Or just how people now you'),
            ),
            ElevatedButton(
              child: const Text('Start chatting now'),
              onPressed: () {
                pushAndReplaceToPage(context, const HomeView());
              }
            )
          ],
        ),
      ),
    );
  }
}

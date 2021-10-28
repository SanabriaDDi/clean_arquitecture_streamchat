import 'package:clean_architecture_streamchat/navigator_utils.dart';
import 'package:clean_architecture_streamchat/ui/sign_in/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = StreamChat.of(context).client.state.currentUser;
    final image = user?.image;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            if (image != null) Image.network(image) else const Placeholder(),
            Switch(
              value: false,
              onChanged: (val) {},
            ),
            ElevatedButton(
              child: const Text('LOGOUT'),
              onPressed: () {
                popAllAndPush(context, const SignInView());
              },
            )
          ],
        ),
      ),
    );
  }
}

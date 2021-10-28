import 'package:clean_architecture_streamchat/navigator_utils.dart';
import 'package:clean_architecture_streamchat/ui/profile_verify/profile_verify_view.dart';
import 'package:flutter/material.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to FlutterChat'),
            ElevatedButton(
              child: const Text('Login with Google'),
              onPressed: () {
                pushAndReplaceToPage(context, const ProfileVeifyView());
              },
            )
          ],
        ),
      ),
    );
  }
}

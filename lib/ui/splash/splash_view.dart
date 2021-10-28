import 'package:clean_architecture_streamchat/navigator_utils.dart';
import 'package:clean_architecture_streamchat/ui/sign_in/sign_in_view.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: ElevatedButton(
            child: const Text('NEXT'),
            onPressed: () {
            //pushAndReplaceToPage(context, const ProfileVeifyView());
            pushAndReplaceToPage(context, const SignInView());
          }
        ),
      ),
    );
  }
}

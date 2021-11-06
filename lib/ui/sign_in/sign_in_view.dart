import 'package:clean_architecture_streamchat/navigator_utils.dart';
import 'package:clean_architecture_streamchat/ui/home/home_view.dart';
import 'package:clean_architecture_streamchat/ui/profile_verify/profile_verify_view.dart';
import 'package:clean_architecture_streamchat/ui/sign_in/sign_in_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(loginUseCase: context.read()),
      child: BlocConsumer<SignInCubit, SignInState>(
        listener: (context, state) {
          if (state == SignInState.none) {
            pushAndReplaceToPage(context, const ProfileVeifyView());
          } else {
            pushAndReplaceToPage(context, const HomeView());
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Welcome to FlutterChat'),
                  ElevatedButton(
                    child: const Text('Login with Google'),
                    onPressed: () {
                      context.read<SignInCubit>().signIn();
                    },
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

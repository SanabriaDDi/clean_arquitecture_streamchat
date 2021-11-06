import 'package:clean_architecture_streamchat/navigator_utils.dart';
import 'package:clean_architecture_streamchat/ui/home/home_view.dart';
import 'package:clean_architecture_streamchat/ui/profile_verify/profile_verify_view.dart';
import 'package:clean_architecture_streamchat/ui/sign_in/sign_in_view.dart';
import 'package:clean_architecture_streamchat/ui/splash/initial_background_view.dart';
import 'package:clean_architecture_streamchat/ui/splash/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(loginUseCase: context.read())..init(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state == SplashState.none) {
            pushAndReplaceToPage(context, const SignInView());
          } else if (state == SplashState.existingUser) {
            pushAndReplaceToPage(context, const HomeView());
          } else {
            pushAndReplaceToPage(context, const ProfileVeifyView());
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              const InitialBackgroundView(),
              Center(
                child: Hero(
                  tag: 'logo_hero',
                  child: Image.asset(
                    'assets/mydashatar.png',
                    height: 100,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

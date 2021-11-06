import 'package:clean_architecture_streamchat/navigator_utils.dart';
import 'package:clean_architecture_streamchat/ui/home/home_view.dart';
import 'package:clean_architecture_streamchat/ui/profile_verify/profile_verify_view.dart';
import 'package:clean_architecture_streamchat/ui/sign_in/sign_in_cubit.dart';
import 'package:clean_architecture_streamchat/ui/splash/initial_background_view.dart';
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
              backgroundColor: Theme.of(context).canvasColor,
              body: Stack(
                children: [
                  const InitialBackgroundView(),
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 150,
                        ),
                        Hero(
                          tag: 'logo_hero',
                          child: Image.asset(
                            'assets/mydashatar.png',
                            height: 80,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          'Welcome to\nFlutterChat',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 40),
                          child: Text(
                            'A platform to chat with users very easily and friendly',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Material(
                          elevation: 4,
                          shadowColor: Colors.black45,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Theme.of(context)
                              .bottomNavigationBarTheme
                              .backgroundColor,
                          child: InkWell(
                            onTap: () {
                              context.read<SignInCubit>().signIn();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/icon-google.png',
                                    height: 20,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  const Text('Login with Google'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            '"in the modern world the\nquality of the life is the quality\nof communication"',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}

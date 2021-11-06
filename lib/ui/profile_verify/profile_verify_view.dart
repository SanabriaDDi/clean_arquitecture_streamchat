import 'package:clean_architecture_streamchat/navigator_utils.dart';
import 'package:clean_architecture_streamchat/ui/common/avatar_image_view.dart';
import 'package:clean_architecture_streamchat/ui/home/home_view.dart';
import 'package:clean_architecture_streamchat/ui/profile_verify/profile_verify_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileVeifyView extends StatelessWidget {
  const ProfileVeifyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileVerifyCubit(
        imagePickerRepository: context.read(),
        profileSignInUseCase: context.read(),
      ),
      child: BlocConsumer<ProfileVerifyCubit, ProfileState>(
        listener: (context, state) {
          if (state.success) {
            pushAndReplaceToPage(context, const HomeView());
          }
        },
        builder: (context, state) {
          //refresh the photo
          return Scaffold(
            backgroundColor: Theme.of(context).canvasColor,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Verify your identity',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  AvatartImageView(
                    onTap: () => context.read<ProfileVerifyCubit>().pickImage(),
                    child: state.file != null
                        ? Image.file(
                            state.file!,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.person_outlined,
                            size: 100,
                            color: Colors.grey[400],
                          ),
                  ),
                  const Text(
                    'Your name',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50.0,
                      vertical: 20.0,
                    ),
                    child: TextField(
                      controller:
                          context.read<ProfileVerifyCubit>().nameController,
                      decoration: InputDecoration(
                        fillColor: Theme.of(context)
                            .bottomNavigationBarTheme
                            .backgroundColor,
                        hintText: 'Or just how people now you',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[400],
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Hero(
                    tag: 'home_hero',
                    child: Material(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Theme.of(context).accentColor,
                      child: InkWell(
                          onTap: () {
                            context.read<ProfileVerifyCubit>().startChatting();
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 30.0,
                              vertical: 15.0,
                            ),
                            child: Text(
                              'Start chatting now',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )),
                    ),
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

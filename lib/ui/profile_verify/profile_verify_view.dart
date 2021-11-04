import 'package:clean_architecture_streamchat/navigator_utils.dart';
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
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Verify your identity'),
                  if (state.file != null)
                    Image.file(state.file!, height: 150,)
                  else
                    const Placeholder(
                      fallbackHeight: 100,
                      fallbackWidth: 100,
                    ),
                  IconButton(
                    icon: const Icon(Icons.photo),
                    onPressed: () =>
                        context.read<ProfileVerifyCubit>().pickImage(),
                  ),
                  const Text('Your name'),
                  TextField(
                    controller:
                        context.read<ProfileVerifyCubit>().nameController,
                    decoration: const InputDecoration(
                        hintText: 'Or just how people now you'),
                  ),
                  ElevatedButton(
                      child: const Text('Start chatting now'),
                      onPressed: () {
                        context.read<ProfileVerifyCubit>().startChatting();
                      })
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:clean_architecture_streamchat/navigator_utils.dart';
import 'package:clean_architecture_streamchat/ui/app_theme_cubit.dart';
import 'package:clean_architecture_streamchat/ui/home/settings/settings_cubit.dart';
import 'package:clean_architecture_streamchat/ui/sign_in/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = StreamChat.of(context).client.state.currentUser;
    final image = user?.image;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              SettingsSwitchCubit(context.read<AppThemeCubit>().isDark),
        ),
        BlocProvider(
          create: (_) => SettingsLogoutCubit(logoutUseCase: context.read()),
        )
      ],
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              if (image != null) Image.network(image) else const Placeholder(),
              BlocBuilder<SettingsSwitchCubit, bool>(
                builder: (context, state) {
                  return Switch(
                      value: state,
                      onChanged: (val) {
                        context
                            .read<SettingsSwitchCubit>()
                            .onChangeDarkMode(val);
                        context.read<AppThemeCubit>().updateTheme(val);
                      });
                },
              ),
              Builder(builder: (context) {
                return BlocListener<SettingsLogoutCubit, void>(
                  listener: (context, state) {
                    popAllAndPush(context, const SignInView());
                  },
                  child: ElevatedButton(
                    child: const Text('LOGOUT'),
                    onPressed: () {
                      context.read<SettingsLogoutCubit>().logOut();
                    },
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:clean_architecture_streamchat/navigator_utils.dart';
import 'package:clean_architecture_streamchat/ui/app_theme_cubit.dart';
import 'package:clean_architecture_streamchat/ui/common/avatar_image_view.dart';
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
    final textColor = Theme.of(context).appBarTheme.backgroundColor;
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
        backgroundColor: Theme.of(context).canvasColor,
        appBar: AppBar(
          title: Text(
            'Settings',
            style: TextStyle(
              fontSize: 24,
              color: textColor,
              fontWeight: FontWeight.w800,
            ),
          ),
          centerTitle: false,
          elevation: 0,
          backgroundColor: Theme.of(context).canvasColor,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                AvatartImageView(
                  //TODO: implement change avatar
                  onTap: () => null,
                  child: image != null
                      ? Image.network(
                          image,
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          Icons.person_outline,
                          size: 100,
                          color: Colors.grey[400],
                        ),
                ),
                Text(
                  user!.name,
                  style: TextStyle(
                    fontSize: 24,
                    color: textColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.nights_stay_outlined,
                      color: textColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Dark mode',
                      style: TextStyle(
                        color: textColor,
                      ),
                    ),
                    const Spacer(),
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
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Builder(
                  builder: (context) {
                    return GestureDetector(
                      onTap: () => context.read<SettingsLogoutCubit>().logOut(),
                      child: BlocListener<SettingsLogoutCubit, void>(
                        listener: (context, state) {
                          popAllAndPush(context, const SignInView());
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              color: textColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Logout',
                              style: TextStyle(
                                color: textColor,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_right,
                              color: textColor,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

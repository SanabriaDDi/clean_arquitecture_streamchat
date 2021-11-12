import 'package:clean_architecture_streamchat/dependencies.dart';
import 'package:clean_architecture_streamchat/ui/app_theme_cubit.dart';
import 'package:clean_architecture_streamchat/ui/splash/splash_view.dart';
import 'package:clean_architecture_streamchat/ui/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

void main() async {
  final streamChatClient = StreamChatClient('2atgbrabyt2p');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(streamChatClient));
}

class MyApp extends StatelessWidget {
  final StreamChatClient _streamChatClient;

  const MyApp(StreamChatClient streamChatClient, {Key? key})
      : _streamChatClient = streamChatClient,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return MultiRepositoryProvider(
      providers: buildRepositories(_streamChatClient),
      child: BlocProvider(
        create: (context) =>
            AppThemeCubit(persistenStorageRepository: context.read())..init(),
        child: BlocBuilder<AppThemeCubit, bool>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'FlutterChat',
              home: const SplashView(),
              theme: Themes.themeLight,
              darkTheme: Themes.themeDark,
              themeMode: state ? ThemeMode.dark : ThemeMode.light,
              builder: (context, child) {
                return StreamChat(
                  child: child,
                  client: _streamChatClient,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

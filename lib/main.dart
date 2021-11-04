import 'package:clean_architecture_streamchat/dependencies.dart';
import 'package:clean_architecture_streamchat/ui/app_theme_cubit.dart';
import 'package:clean_architecture_streamchat/ui/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

void main() async {
  final streamChatClient = await _fakeUser();

  runApp(MyApp(streamChatClient));
}

Future<StreamChatClient> _fakeUser() async {
  final _streamChatClient = StreamChatClient('2atgbrabyt2p');
  /*await _streamChatClient.connectUser(
      User(
        id: 'diego',
      ),
      _streamChatClient.devToken('diego').rawValue);*/

  return _streamChatClient;
}

class MyApp extends StatelessWidget {
  final StreamChatClient _streamChatClient;

  const MyApp(StreamChatClient streamChatClient, {Key? key})
      : _streamChatClient = streamChatClient,
        super(key: key);

  //final _streamChatClient = StreamChatClient('2atgbrabyt2p');

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
              title: 'FlutterChat',
              home: const SplashView(),
              theme: state ? ThemeData.dark() : ThemeData.light(),
              builder: (context, child) {
                return StreamChat(child: child, client: _streamChatClient);
              },
            );
          },
        ),
      ),
    );
  }
}

import 'package:clean_architecture_streamchat/ui/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _streamChatClient =
      StreamChatClient('2atgbrabyt2p', logLevel: Level.INFO);

  Future<void> connectFakeUser() async {
    await _streamChatClient.disconnectUser();
    await _streamChatClient.connectUser(
      User(id: 'diego'),
      _streamChatClient.devToken('diego').rawValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    connectFakeUser();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return MaterialApp(
      title: 'FlutterChat',
      home: const SplashView(),
      theme: ThemeData.light(),
      builder: (context, child) {
        return StreamChat(child: child, client: _streamChatClient);
      },
    );
  }
}

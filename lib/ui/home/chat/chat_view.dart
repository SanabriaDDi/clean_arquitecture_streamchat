import 'package:clean_architecture_streamchat/ui/common/my_channel_preview.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).appBarTheme.color;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chats',
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
      body: ChannelsBloc(
        child: ChannelListView(
          filter: Filter.in_(
            'members',
            [StreamChat.of(context).currentUser!.id],
          ),
          sort: const [SortOption('last_message_at')],
          channelPreviewBuilder: (context, channel) {
            return MyChannelPreview(
              channel: channel,
              heroTag: channel.id!,
              onImageTap: () {
                late final String? name;
                late final String? image;
                if (channel.isGroup) {
                  name = channel.name;
                  image = channel.image;
                } else {
                  final currentUser =
                      StreamChat.of(context).client.state.currentUser;
                  final friend = channel.state!.members
                      .where((element) => element.userId != currentUser!.id)
                      .first
                      .user!;
                  name = friend.name;
                  image = friend.image;
                }

                Navigator.of(context).push(PageRouteBuilder(
                    barrierColor: Colors.black45,
                    barrierDismissible: true,
                    opaque: false,
                    pageBuilder: (context, animation1, _) {
                      return FadeTransition(
                        opacity: animation1,
                        child: ChatDetailView(
                          image: image ?? '',
                          name: name ?? 'none',
                          channelId: channel.id!,
                        ),
                      );
                    }));
              },
              onTap: (channel) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return StreamChannel(
                          child: const ChannelPage(), channel: channel);
                    },
                  ),
                );
              },
            );
          },
          channelWidget: const ChannelPage(),
        ),
      ),
    );
  }
}

class ChannelPage extends StatelessWidget {
  const ChannelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ChannelHeader(),
      body: Column(
        children: const [
          Expanded(
            child: MessageListView(),
          ),
          MessageInput(),
        ],
      ),
    );
  }
}

class ChatDetailView extends StatelessWidget {
  final String image;
  final String name;
  final String channelId;

  const ChatDetailView({
    Key? key,
    required this.image,
    required this.name,
    required this.channelId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Navigator.of(context).pop,
      child: Material(
        color: Colors.transparent,
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (image != '') ...[
                    Hero(
                      tag: channelId,
                      child: ClipOval(
                        child: Image.network(
                          image,
                          width: 180,
                          height: 180,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

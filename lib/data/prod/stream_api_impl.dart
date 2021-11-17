import 'package:clean_architecture_streamchat/data/stream_api_repository.dart';
import 'package:clean_architecture_streamchat/domain/models/chat_user.dart';
import 'package:dio/dio.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class StreamApiImpl extends StreamApiRepository {
  final StreamChatClient _client;

  StreamApiImpl({required StreamChatClient client}) : _client = client;

  @override
  Future<ChatUser> connectUser(
      {required ChatUser user, required String token}) async {
    Map<String, dynamic> extraData = {};
    if (user.image != null) {
      extraData['image'] = user.image;
    }
    extraData['name'] = user.name;
    await _client.disconnectUser();
    await _client.connectUser(User(id: user.id, extraData: extraData), token);

    return user;
  }

  @override
  Future<List<ChatUser>> getChatUsers() async {
    final result = await _client.queryUsers(
      filter: Filter.equal('banned', false),
    );
    final chatUsers = result.users
        .where((element) => element.id != _client.state.currentUser!.id)
        .map(
          (e) => ChatUser(
            name: e.name,
            id: e.id,
            image: e.image,
          ),
        )
        .toList();
    return chatUsers;
  }

  @override
  Future<String> getToken({required String userId}) async {
    final dio = Dio();

    final response = await dio.post(
      'http://192.168.1.106:5000/token',
      data: {'id': userId},
    );

    return response.data['token'];
  }

  @override
  Future<Channel> createGroupChat(
      {required String channelId,
      required String name,
      required List<String> members,
      String? image}) async {
    final channel = _client.channel('messaging', id: channelId, extraData: {
      'name': name,
      'image': image,
      'members': [_client.state.currentUser!.id, ...members],
    });
    await channel.watch();
    return channel;
  }

  @override
  Future<Channel> createSimpleChat({required String friendId}) async {
    final channel = _client.channel('messaging',
        id: '${_client.state.currentUser!.id.hashCode}${friendId.hashCode}',
        extraData: {
          'members': [friendId, _client.state.currentUser!.id]
        });
    await channel.watch();
    return channel;
  }

  @override
  Future<void> logout() {
    return _client.disconnectUser();
  }

  @override
  Future<bool> connectIfExists({required String userId}) async {
    final token = await getToken(userId: userId);
    await _client.connectUser(
      User(id: userId),
      token,
    );
    return _client.state.currentUser?.name != null &&
        _client.state.currentUser?.name != userId;
  }
}

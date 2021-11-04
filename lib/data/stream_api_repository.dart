import 'package:clean_architecture_streamchat/domain/models/chat_user.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

abstract class StreamApiRepository {
  Future<List<ChatUser>> getChatUsers();

  Future<String> getToken({required String userId});

  Future<bool> connectIfExists({required String userId});

  Future<ChatUser> connectUser({required ChatUser user, required String token});

  Future<Channel> createGroupChat(
      {required String channelId,
      required String name,
      required List<String> members,
      String? image});

  Future<Channel> createSimpleChat({required String friendId});

  Future<void> logout();
}

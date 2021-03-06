import 'package:clean_architecture_streamchat/data/auth_repository.dart';
import 'package:clean_architecture_streamchat/data/image_picker_repository.dart';
import 'package:clean_architecture_streamchat/data/local/image_picker_impl.dart';
import 'package:clean_architecture_streamchat/data/persisten_storage_repository.dart';
import 'package:clean_architecture_streamchat/data/prod/auth_impl.dart';
import 'package:clean_architecture_streamchat/data/prod/persisten_storage_impl.dart';
import 'package:clean_architecture_streamchat/data/prod/stream_api_impl.dart';
import 'package:clean_architecture_streamchat/data/prod/upload_storage_impl.dart';
import 'package:clean_architecture_streamchat/data/stream_api_repository.dart';
import 'package:clean_architecture_streamchat/data/upload_storage_repository.dart';
import 'package:clean_architecture_streamchat/domain/usecases/create_group_use_case.dart';
import 'package:clean_architecture_streamchat/domain/usecases/login_usecase.dart';
import 'package:clean_architecture_streamchat/domain/usecases/logout_usecase.dart';
import 'package:clean_architecture_streamchat/domain/usecases/profile_sign_in_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

List<RepositoryProvider> buildRepositories(StreamChatClient client) {
  return [
    RepositoryProvider<StreamApiRepository>(
      create: (_) => StreamApiImpl(client: client),
    ),
    RepositoryProvider<PersistenStorageRepository>(
      create: (_) => PersistenStorageImpl(),
    ),
    RepositoryProvider<AuthRepository>(create: (_) => AuthImpl()),
    RepositoryProvider<UploadStorageRepository>(
      create: (_) => UploadStorageImpl(),
    ),
    RepositoryProvider<ImagePickerRepository>(
      create: (_) => ImagePickerImpl(),
    ),
    RepositoryProvider<ProfileSignInUseCase>(
      create: (context) => ProfileSignInUseCase(
        context.read(),
        context.read(),
        context.read(),
      ),
    ),
    RepositoryProvider<CreateGroupUseCase>(
      create: (context) => CreateGroupUseCase(
        context.read(),
        context.read(),
      ),
    ),
    RepositoryProvider<LogoutUseCase>(
      create: (context) => LogoutUseCase(
        context.read(),
        context.read(),
      ),
    ),
    RepositoryProvider<LoginUseCase>(
      create: (context) => LoginUseCase(
        context.read(),
        context.read(),
      ),
    ),
  ];
}

import 'package:whats_app/core/models/user_model.dart';
import 'package:whats_app/features/chat/repository/chat_repository.dart';

class ChatController {
  final ChatRepository chatRepository;
  ChatController(this.chatRepository);

  Stream<UserModel> getUserInfo(String uid) async*{
    yield* chatRepository.getUserInfo(uid);
  }
}

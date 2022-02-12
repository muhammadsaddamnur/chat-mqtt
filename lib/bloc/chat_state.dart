part of 'chat_bloc.dart';

@immutable
abstract class ChatState {
  final List<String> messages;

  const ChatState(this.messages);
}

class ChatInitial extends ChatState {
  ChatInitial() : super([]);
}

class ChatLoading extends ChatState {
  ChatLoading() : super([]);
}

class ChatSuccess extends ChatState {
  const ChatSuccess(List<String> messages) : super(messages);
}

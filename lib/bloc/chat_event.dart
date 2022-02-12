part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class SendMessage extends ChatEvent {
  final String message;

  SendMessage(this.message);
}

class RemoveMessage extends ChatEvent {}

class ConnectMqtt extends ChatEvent {}

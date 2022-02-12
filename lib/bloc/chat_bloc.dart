import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<SendMessage>((event, emit) async {
      // emit(ChatLoading([]));
      // await Future.delayed(const Duration(seconds: 2));
      List<String> m = state.messages;
      m.add(event.message);
      emit(ChatSuccess(m));
    });

    on<RemoveMessage>((event, emit) {
      emit(ChatInitial());
    });
  }
}

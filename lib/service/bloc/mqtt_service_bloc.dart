import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:typed_data/typed_buffers.dart';

part 'mqtt_service_event.dart';
part 'mqtt_service_state.dart';

class MqttServiceBloc extends Bloc<MqttServiceEvent, MqttServiceState> {
  MqttServiceBloc()
      : super(
          MqttServiceInitial(
            MqttServerClient('broker.emqx.io', 'android'),
          ),
        ) {
    on<MqttInit>((event, emit) async {
      MqttServerClient client = MqttServerClient('broker.emqx.io', 'android');
      client.onConnected = () => add(OnConnected());
      client.onDisconnected = () => add(OnDisconnected());

      emit(MqttServiceFilled(client));

      await state.client.connect();

      if (state.client.connectionStatus!.state ==
          MqttConnectionState.connected) {
        state.client.subscribe('flutter/chat', MqttQos.exactlyOnce);
      }

      state.client.published!.listen((a) {
        print('isi publish > ${a.payload}');
      });
      state.client.updates!.listen((a) {
        final MqttPublishMessage recMessage =
            a.first.payload as MqttPublishMessage;
        final String pt = MqttPublishPayload.bytesToStringAsString(
            recMessage.payload.message);
        if (pt == 'server') {
          add(Send('saddam'));
        }
        print('isi update > $pt');
      });

      print(state.client.connectionStatus!.state);
    });

    on<Disconnect>((event, emit) {
      state.client.disconnect();
      print(state.client.connectionStatus!.state);
    });

    on<Send>((event, emit) {
      Uint8Buffer dataBuffer = Uint8Buffer();
      dataBuffer.addAll(event.message.codeUnits);
      state.client.publishMessage(
        'flutter/chat',
        MqttQos.exactlyOnce,
        dataBuffer,
        retain: true,
      );
    });

    on<OnConnected>((event, emit) {
      print('connected');
    });
    on<OnDisconnected>((event, emit) {
      print('disconnected');
    });
  }
}

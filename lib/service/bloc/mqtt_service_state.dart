part of 'mqtt_service_bloc.dart';

@immutable
abstract class MqttServiceState {
  final MqttServerClient client;

  const MqttServiceState(this.client);
}

class MqttServiceInitial extends MqttServiceState {
  const MqttServiceInitial(MqttServerClient client) : super(client);
}

class MqttServiceFilled extends MqttServiceState {
  const MqttServiceFilled(MqttServerClient client) : super(client);
}

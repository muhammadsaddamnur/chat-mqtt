part of 'mqtt_service_bloc.dart';

@immutable
abstract class MqttServiceEvent {}

class MqttInit extends MqttServiceEvent {}

class Disconnect extends MqttServiceEvent {}

class Send extends MqttServiceEvent {
  final String message;

  Send(this.message);
}

class OnConnected extends MqttServiceEvent {}

class OnDisconnected extends MqttServiceEvent {}

import 'package:chat_mqtt/bloc/chat_bloc.dart';
import 'package:chat_mqtt/detail.dart';
import 'package:chat_mqtt/service/bloc/mqtt_service_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_client/mqtt_client.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    Future.microtask(() {
      final mqttBloc = BlocProvider.of<MqttServiceBloc>(context);
      mqttBloc.add(MqttInit(clientIdentifier));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataBloc = BlocProvider.of<ChatBloc>(context);
    final mqttBloc = BlocProvider.of<MqttServiceBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<MqttServiceBloc, MqttServiceState>(
          builder: (context, state) {
            return Text(state.client.clientIdentifier);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Detail()));
            },
            icon: const Icon(Icons.golf_course),
          ),
          IconButton(
            onPressed: () {
              mqttBloc.add(MqttInit('saddam'));
            },
            icon: const Icon(Icons.connect_without_contact),
          ),
          IconButton(
            onPressed: () {
              mqttBloc.add(Disconnect());
            },
            icon: const Icon(Icons.cancel),
          ),
          IconButton(
            onPressed: () {
              dataBloc.add(RemoveMessage());
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Column(
        children: [
          // Expanded(
          //   child: BlocBuilder<ChatBloc, ChatState>(
          //     builder: (context, state) {
          //       return ListView.builder(
          //         itemCount: state.messages.length,
          //         itemBuilder: ((context, index) {
          //           if (state is ChatSuccess) {
          //             return Text(state.messages[index]);
          //           }
          //           return const Text('data');
          //         }),
          //       );
          //     },
          //   ),
          // ),
          Expanded(
            child: BlocBuilder<MqttServiceBloc, MqttServiceState>(
              builder: (context, state) {
                if (state is MqttServiceInitial) {
                  return SizedBox();
                }
                return StreamBuilder<List<MqttReceivedMessage<MqttMessage>>>(
                  stream: state.client.updates,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final MqttPublishMessage recMessage =
                          snapshot.data!.first.payload as MqttPublishMessage;
                      final String pt =
                          MqttPublishPayload.bytesToStringAsString(
                              recMessage.payload.message);

                      return Text(pt.toString());

                      // return ListView.builder(
                      //   itemCount: chats.length,
                      //   itemBuilder: (context, index) {
                      //     return Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Text(chats[index].toString()),
                      //     );
                      //   },
                      // );
                    }
                    return const SizedBox();
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      // dataBloc.add(SendMessage(_controller.text));
                      mqttBloc.add(Send(_controller.text));
                    },
                    icon: const Icon(Icons.send))
              ],
            ),
          )
        ],
      ),
    );
  }
}

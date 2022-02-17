import 'package:chat_mqtt/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'service/bloc/mqtt_service_bloc.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          reverse: true,
          children: [
            ElevatedButton(
                onPressed: () {
                  MqttServiceBloc mqttBloc =
                      BlocProvider.of<MqttServiceBloc>(context);
                  mqttBloc.add(MqttInit(username.text));
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Chat()));
                },
                child: Text('Masuk')),
            TextField(
              controller: username,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:chat_mqtt/bloc/chat_bloc.dart';
import 'package:chat_mqtt/chat.dart';
import 'package:chat_mqtt/service/bloc/mqtt_service_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ChatBloc(),
        ),
        BlocProvider(
          create: (context) => MqttServiceBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Chat(),
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     final dataBloc = BlocProvider.of<ChatBloc>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//           child: BlocListener<ChatBloc, ChatState>(
//         listener: (context, state) {
//           // TODO: implement listener
//         },
//         child: BlocBuilder<ChatBloc, ChatState>(
//           builder: (context, state) {
//             if (state is ChatInitial) {
//               return Text('wkwk');
//             }
//             if (state is ChatLoading) {
//               return CircularProgressIndicator();
//             }
//             if (state is ChatSuccess) {
//               return Text(state.message);
//             }
//             return SizedBox();
//           },
//         ),
//       )),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           dataBloc.add(Process());
//         },
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

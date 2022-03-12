import 'package:firebase_app/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBpYHVbomi205OcU5LvsRcl-ICdm1KjmsA',
          appId: '1:807875866174:android:92c8d544a22ede02fe6b6f',
          messagingSenderId: '807875866174',
          projectId: 'fluttermeetingapp-df913'));
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Board(),
    );
  }
}

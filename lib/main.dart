import 'package:flutter/material.dart';

import '/theme.dart';
import 'pages/chat_bot_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ChatGPT SDK Flutter',
        theme: theme,
        home: const ChatBotPage(),
      );
}

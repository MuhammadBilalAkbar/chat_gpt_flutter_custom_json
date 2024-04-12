import 'package:flutter/material.dart';

import 'chat_bot_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'ChatGPT SDK Flutter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.teal,
          appBarTheme: AppBarTheme(
            titleTextStyle:
                const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            color: Colors.teal[300],
          ),
        ),
        home: const ChatBotPage(),
      );
}

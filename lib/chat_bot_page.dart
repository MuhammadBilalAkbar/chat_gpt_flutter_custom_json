import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'model/MessageModel.dart';
import 'model/ResponseModel.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  static const kDefault = 15.0;
  final messageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  static const apiKey = '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';
  final messages = [MessageModel(true, 'Hi')];
  bool isAiTyping = false;

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('ChatGPT in Flutter'),
          leading: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: CircleAvatar(
              backgroundImage: AssetImage('chatGptImage.png'),
            ),
          ),
        ),
        body: Form(
          key: formKey,
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final isBot = messages[index].isBot;
                    final alignment =
                        isBot ? Alignment.centerLeft : Alignment.centerRight;
                    return Align(
                      alignment: alignment,
                      child: userCard(
                        index: index,
                        alignment: alignment,
                        isBot: isBot,
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefault / 2,
                    vertical: kDefault / 1.5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(kDefault),
                      topLeft: Radius.circular(kDefault),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.23),
                        offset: const Offset(kDefault / 1.2, .5),
                        blurRadius: kDefault,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(.12),
                            borderRadius: BorderRadius.circular(kDefault * 3.33),
                          ),
                          child: TextFormField(
                            controller: messageController,
                            autofocus: true,
                            decoration: const InputDecoration(
                              hintText: 'Enter question here',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(kDefault)
                            ),
                            textInputAction: TextInputAction.send,
                            validator: (value) =>
                                value!.isEmpty ? 'Enter some question' : null,
                          ),
                        ),
                      ),
// suffixIcon:
                      isAiTyping
                          ? Transform.scale(
                              scale: 0.8,
                              child: const CircularProgressIndicator(
                                strokeWidth: 5,
                                color: Color(0xff0360a6),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                sendMessage();
                              },
                              child: Container(
                                margin: const EdgeInsets.all(kDefault / 2),
                                width: kDefault * 3,
                                height: kDefault * 3,
                                decoration: BoxDecoration(
                                  color: const Color(0xff0360a6),
                                  borderRadius:
                                      BorderRadius.circular(kDefault * 3.33),
                                ),
                                child: const Icon(
                                  Icons.send,
                                  size: kDefault * 1.6,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );

  Padding userCard({
    required int index,
    required Alignment alignment,
    required bool isBot,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefault,
        vertical: kDefault,
      ),
      child: Stack(
        children: [
          Align(
            alignment: alignment,
            child: isBot
                ? const CircleAvatar(
                    backgroundImage: AssetImage('chatGptImage.png'),
                    radius: 18,
                  )
                : const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
          ),
          Align(
            alignment: alignment,
            child: Container(
              // height: ,
              margin: isBot
                  ? const EdgeInsets.only(
                      right: kDefault / 2,
                      left: kDefault * 3.6,
                    )
                  : const EdgeInsets.only(
                      left: kDefault / 2,
                      right: kDefault * 3.6,
                    ),
              padding: isBot
                  ? const EdgeInsets.symmetric(
                      horizontal: kDefault * 1.2,
                      vertical: kDefault / 1.2,
                    )
                  : const EdgeInsets.symmetric(
                      horizontal: kDefault * 1.2,
                      vertical: kDefault / 1.2,
                    ),
              decoration: BoxDecoration(
                color:
                    isBot ? const Color(0xffffffff) : const Color(0xff0360a6),
                borderRadius: isBot
                    ? const BorderRadius.only(
                        bottomLeft: Radius.circular(kDefault * 3.33),
                        bottomRight: Radius.circular(kDefault * 3.33),
                        topRight: Radius.circular(kDefault * 3.33),
                      )
                    : const BorderRadius.only(
                        bottomRight: Radius.circular(kDefault * 3.33),
                        bottomLeft: Radius.circular(kDefault * 3.33),
                        topLeft: Radius.circular(kDefault * 3.33),
                      ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(kDefault / 5, kDefault / 5),
                    blurRadius: kDefault * 0.5,
                  ),
                ],
              ),
              child: Text(
                messages[index].message.trim(),
                style: TextStyle(
                  color:
                      isBot ? const Color(0xff0360a6) : const Color(0xffffffff),
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void sendMessage() async {
    if (formKey.currentState!.validate()) {
      messages.add(
        MessageModel(false, messageController.text),
      );
      setState(() => isAiTyping = true);

      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey'
        },
        body: jsonEncode(
          {
            "model": "gpt-3.5-turbo",
            "messages": [
              {
                "role": "user",
                "content": messageController.text,
              },
            ],
          },
        ),
      );
      messageController.clear();
      debugPrint('response :$response');
      debugPrint('response.body :${response.body}');
      debugPrint('response.statusCode :${response.statusCode}');
      if (response.statusCode == 200) {
        setState(() {
          final responseModel = ResponseModel.fromJson(
            jsonDecode(response.body),
          );
          messages.add(
            MessageModel(
              true,
              responseModel.choices[0].message!.content.toString(),
            ),
          );
          isAiTyping = false;
        });
      }
    }
  }
}

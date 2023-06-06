import 'package:chatgpt/ApiService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Main_Screen extends StatefulWidget {
  const Main_Screen({super.key});

  @override
  State<Main_Screen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<Main_Screen> {
  final ChatGPT _chatGPT = ChatGPT("Your API key");
  final TextEditingController chatController = TextEditingController();

  List<ChatGPTModel> chatList = [];

  bool isLoading = false;

  void send(String message) async {
    chatController
        .clear(); //we want to clear our command in text field after sending it to bot
    setState(() {
      isLoading = true;
      chatList.add(
        ChatGPTModel(
          message: message,
          sender: 'User',
        ),
      );
    });

    final response = await _chatGPT.sendMessage(message);

    setState(() {
      isLoading = false;
      chatList.add(
        ChatGPTModel(
          message: response,
          sender: 'Bot',
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15.0), top: Radius.circular(15.0)),
        ),
        title: const Text('ChattyAI'),
        centerTitle: true,
        // we want our title in center of appbar
        leading: IconButton(
          onPressed: () {
            setState(() {
              chatList.clear();
            });
          },
          icon: const Icon(Icons.delete_outline_outlined),
          color: Colors.indigo,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.view_sidebar_rounded),
            color: Colors.indigo,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: chatList.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          CupertinoIcons.chat_bubble_2,
                          size: 60.0,
                          color: Colors.indigo,
                        ),
                        Text(
                          'Empty :)',
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.indigo),
                        )
                      ],
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            //we give the Chat screen all of the possible space in Main Screen
                            itemCount: chatList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                borderRadius: BorderRadius.circular(15.0),
                                onTap: () {
                                  Clipboard.setData(
                                    ClipboardData(
                                      text: chatList[index].message.trim(),
                                    ),
                                  ).then((value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        //backgroundColor: Colors.grey.shade900,
                                        content: Text('Copied'),
                                      ),
                                    );
                                  });
                                },
                                child: Container(
                                  // Simple Chat Screen
                                  margin: const EdgeInsets.all(6.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: chatList[index].sender == 'User'
                                        ? Colors.grey.shade900
                                        : Colors.indigo,
                                  ),
                                  child: ListTile(
                                      title: SelectableText(
                                          chatList[index].message.trim()),
                                      leading: chatList[index].sender == 'User'
                                          ? const Icon(Icons.person)
                                          : const Icon(
                                              Icons.bolt_rounded,
                                            )),
                                ),
                              );
                            },
                          ),
                        ),
                        isLoading
                            ? Container(
                                margin: const EdgeInsets.only(bottom: 16.0),
                                child: CupertinoActivityIndicator(),
                              )
                            : const SizedBox()
                      ],
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                onSubmitted: send,
                controller: chatController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                        onPressed: () {
                          send(chatController.text);
                        },
                        icon: const Icon(Icons.send)),
                    hintText:
                        'Write your command...' // Here we type our command to chatgpt
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

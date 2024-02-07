import 'package:flutter/material.dart';

void main() {
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatBox(),
    );
  }
}

class ChatMessage {
  final String text;
  final String sender;
  final DateTime time;

  ChatMessage({
    required this.text,
    required this.sender,
    required this.time,
  });
}

class ChatBox extends StatefulWidget {
  const ChatBox({Key? key}) : super(key: key);

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  List<ChatMessage> messages = [];
  final TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat Box',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0), // Set the preferred height
          child: Container(
            height: 4.0, // Set the color of the separator line
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              reverse: true,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ChatMessageBubble(
                  message: message.text,
                  sender: message.sender,
                  isMe: message.sender == 'You',
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Type a message',
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    final String messageText = _messageController.text.trim();
                    if (messageText.isNotEmpty) {
                      setState(() {
                        messages.add(ChatMessage(
                          text: messageText,
                          sender: 'You',
                          time: DateTime.now(),
                        ));
                        _messageController.clear();
                      });
                    }
                  },
                  style: TextButton.styleFrom(
                    foregroundColor:
                        Colors.black, // Set the text color to black
                  ),
                  child: const Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessageBubble extends StatelessWidget {
  final String message;
  final String sender;
  final bool isMe;

  const ChatMessageBubble({
    required this.message,
    required this.sender,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: isMe ? Colors.blue : Colors.grey[300],
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isMe ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            message,
            style: TextStyle(color: isMe ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:convert';

class ChatScreen extends StatefulWidget {
  final String username;
  final String userImage;
  const ChatScreen({super.key, required this.username, required this.userImage});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> messages = [];

  late StreamController<String> streamController;

  @override
  void initState() {
    super.initState();

    // Initialize StreamController
    streamController = StreamController<String>();

    // Listen to the "simulated WebSocket"
    streamController.stream.listen((data) {
      final decoded = jsonDecode(data);
      setState(() {
        messages.add({
          'text': decoded['text'],
          'isMe': false,
          'timestamp': DateTime.now(),
        });
      });

      _scrollToBottom();
    });
  }

  void sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        messages.add({
          'text': text,
          'isMe': true,
          'timestamp': DateTime.now(),
        });
        _messageController.clear();
      });

      _scrollToBottom();

      // Simulate server response after 1 second
      Future.delayed(const Duration(seconds: 1), () {
        final reply = {
          'text': _generateAutoReply(text),
        };
        streamController.add(jsonEncode(reply));
      });
    }
  }

  String _generateAutoReply(String input) {
    final responses = [
      "Sounds great!",
      "Tell me more!",
      "Interesting, go on...",
      "Haha, really?",
      "I'm not sure about that.",
      "Let's talk about that later.",
    ];
    return responses[DateTime.now().second % responses.length];
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    streamController.close();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Row(
          children: [
            CircleAvatar(backgroundImage: AssetImage(widget.userImage)),
            const SizedBox(width: 10),
            Text(widget.username),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isMe = msg['isMe'];
                final time = DateFormat.jm().format(msg['timestamp']);

                return Column(
                  crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 14),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      decoration: BoxDecoration(
                        color: isMe
                            ? Colors.deepPurpleAccent
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(12),
                          topRight: const Radius.circular(12),
                          bottomLeft:
                          isMe ? const Radius.circular(12) : Radius.zero,
                          bottomRight:
                          isMe ? Radius.zero : const Radius.circular(12),
                        ),
                      ),
                      child: Text(
                        msg['text'],
                        style: TextStyle(
                          color: isMe ? Colors.white : Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                      child: Text(
                        time,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: TextField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    hintText: 'Type a message',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.send, color: Colors.deepPurple),
            ),
          ],
        ),
      ),
    );
  }
}
import 'dart:async';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<String> messages = [
    "Hi there!",
    "Hello! How are you?",
    "I'm good, just working on a project.",
    "Sounds interesting. What kind of project? Sounds interesting. What kind of project? Sounds interesting. What kind of project?",
    "It's a Flutter app. Really fun!",
    "That's great! Flutter is amazing.",
    "Totally agree! What about you?",
    "Just relaxing today.",
  ];

  final List<String> displayedMessages = [];
  String currentMessage = "";
  int messageIndex = 0;
  int wordIndex = 0;

  @override
  void initState() {
    super.initState();
    _startChat();
  }

  void _startChat() {
    Timer.periodic(Duration(milliseconds: 200), (timer) {
      if (messageIndex < messages.length) {
        final words = messages[messageIndex].split(' ');

        if (wordIndex < words.length) {
          setState(() {
            currentMessage += "${words[wordIndex]}${wordIndex + 1 == words.length ? "" : " "}";
            wordIndex++;
          });
        } else {
          setState(() {
            displayedMessages.add(currentMessage.trim());
            currentMessage = "";
            wordIndex = 0;
            messageIndex++;
          });
          timer.cancel();
          Future.delayed(Duration(seconds: 2), () => _startChat());
        }
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: displayedMessages.length + (currentMessage.isNotEmpty ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < displayedMessages.length) {
          return _buildMessageTile(displayedMessages[index], _isUser1(index));
        } else {
          return _buildCurrentMessageTile(currentMessage, _isUser1(index));
          }
      },
    );
  }

  bool _isUser1(int index) {
    return index % 2 == 0 ? true : false;
  }

  Widget _buildMessageTile(String message, bool isUser1) {
    return Align(
      alignment: isUser1 ? Alignment.centerLeft : Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isUser1 ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(8).subtract(isUser1 ?
              BorderRadius.only(bottomLeft: Radius.circular(8)) :
              BorderRadius.only(bottomRight: Radius.circular(8))
            ),
          ),
          child: Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: isUser1 ? Theme.of(context).colorScheme.onSecondary : Theme.of(context).colorScheme.onPrimary
            )
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentMessageTile(String message, bool isUser1) {
    return _AnimatedMessageTile(
      isUser1: isUser1,
      child: Align(
        alignment: isUser1 ? Alignment.centerLeft : Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isUser1 ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(8).subtract(isUser1 ?
              BorderRadius.only(bottomLeft: Radius.circular(8)) :
              BorderRadius.only(bottomRight: Radius.circular(8))
            ),
            ),
            child: Text(
              message,
              style: TextStyle(
                fontSize: 16,
                color: isUser1 ? Theme.of(context).colorScheme.onSecondary : Theme.of(context).colorScheme.onPrimary
              )
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedMessageTile extends StatefulWidget {
  final Widget child;
  final bool isUser1;

  const _AnimatedMessageTile({required this.child, required this.isUser1});

  @override
  State<_AnimatedMessageTile> createState() => _AnimatedMessageTileState();
}

class _AnimatedMessageTileState extends State<_AnimatedMessageTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(widget.isUser1 ? -1.0 : 1.0, 0.0), // Slide in from the corresponding side
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: widget.child,
    );
  }
}

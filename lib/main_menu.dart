import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({ super.key });

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final _gemini = Gemini.instance;
  
  final ChatUser _currentUser = ChatUser(id: '1', firstName: 'user');
  final ChatUser _AIUser = ChatUser(id: '2', firstName: 'AI');

  List<ChatMessage> _messages = <ChatMessage>[];
  List<ChatUser> _typingUsers = <ChatUser>[];

  int _selectedIdx = 1;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("test"),
        centerTitle: true,
        backgroundColor: Colors.green[200],
        leading: const SizedBox(width: 0),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_rounded),
            label: "Personalización"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Resumen"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "Asistente"
          )
        ],
        currentIndex: _selectedIdx,
        selectedItemColor: Colors.green[400],
        onTap: (int index) {
          setState(() {
            _selectedIdx = index;
          });
        },
      ),
      body: <Widget>[
        const Card(child: Text("WIP")),
        Card(
          shadowColor: Colors.transparent,
          margin: const EdgeInsets.all(8.0),
          child: SizedBox.expand(
            child: Center(
              child: Text(
                'Home page',
                style: theme.textTheme.titleLarge,
              ),
            ),
          ),
        ),
        DashChat(
          currentUser: _currentUser,
          messageOptions: MessageOptions(
            currentUserContainerColor: Colors.green[800],
          ),
          onSend: (ChatMessage msg) {
            getChatResponse(msg);
          },
          messages: _messages,
          typingUsers: _typingUsers,
        )
      ][_selectedIdx],
    );
  }

  Future<void> getChatResponse(ChatMessage msg) async {
    setState(() {
      _messages = [msg, ..._messages];
      _typingUsers.add(_AIUser);
    });
    try {
      String question = msg.text;
      _gemini.streamGenerateContent(question, modelName: "models/gemini-1.5-flash").listen((event) {
        ChatMessage? lastMessage = _messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == _AIUser) {
          lastMessage = _messages.removeAt(0);
          String response = event.content?.parts?.fold("", (previous, current) => "$previous ${current.text}") ?? "";
          lastMessage.text += response;
          setState(() {
            _messages = [lastMessage!, ..._messages];
          });
        } else {
          String response = event.content?.parts?.fold("", (previous, current) => "$previous ${current.text}") ?? "";
          ChatMessage message = ChatMessage(user: _AIUser, createdAt: DateTime.now(), text: response);
          setState(() {
            _messages = [message, ..._messages];
          });
        }
      });
    } catch (e) {
      print(e);
    }
    setState(() {
      _typingUsers.remove(_AIUser);
    });
  }
}

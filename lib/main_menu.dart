import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/settings.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'menu_resumen.dart';

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
        title: Text("EnergIA", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: const SizedBox(width: 0),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Theme.of(context).colorScheme.onPrimary,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Settings()),
              );
            },
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
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: (int index) {
          setState(() {
            _selectedIdx = index;
          });
        },
      ),
      body: <Widget>[

        // personalizacion (1)
        const Center(child: Text("En desarrollo!!!")),

        // resumen (2)
        MenuResumen(),

        // asistente (chat) (3)
        DashChat(
          currentUser: _currentUser,
          messageOptions: MessageOptions(
            currentUserContainerColor: Theme.of(context).colorScheme.primary,
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

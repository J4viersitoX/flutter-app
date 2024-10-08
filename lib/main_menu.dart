import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/openai_api_key.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({ super.key });

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {

  final _openAI = OpenAI.instance.build(
    token: OPENAI_API_KEY,
    baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
    enableLog: true,
  );
  
  final ChatUser _currentUser = ChatUser(id: '1', firstName: 'nombre', lastName: 'apellido');
  final ChatUser _gptUser = ChatUser(id: '2', firstName: 'Chat', lastName: 'GPT');

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
      _messages.insert(0, msg);
      _typingUsers.add(_gptUser);
    });

    List<Map<String, dynamic>> messagesHistory = _messages.reversed.toList().map((msg) {
      if (msg.user == _currentUser) {
        return Messages(role: Role.user, content: msg.text).toJson();
      } else {
        return Messages(role: Role.assistant, content: msg.text).toJson();
      }
    }).toList();
    final request = ChatCompleteText(
      model: Gpt4oMini2024ChatModel(),
      messages: messagesHistory,
      maxToken: 200,
    );
    final response = await _openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      if (element.message != null) {
        setState(() {
          _messages.insert(
            0,
            ChatMessage(
              user: _gptUser,
              createdAt: DateTime.now(),
              text: element.message!.content));
        });
      }
    }
    setState(() {
      _typingUsers.remove(_gptUser);
    });
  }
}

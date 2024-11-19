import 'dart:async';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<String> messages = [
    "¿Cuántos viven en tu casa? Esto nos dará una idea de la cantidad de gente que usa los electrodomésticos.",
    "Somos tres en la casa, mi señora, mi hijo y yo.",
    "¿Qué tipo de vivienda tienes? (casa, departamento, etc.) y ¿cuántos metros cuadrados aproximadamente? El tamaño influye en el consumo, especialmente en calefacción o aire acondicionado.",
    "Vivimos en un departamento chico, como de 60 metros cuadrados.",
    "¿Qué electrodomésticos grandes tienes? (refrigerador, lavadora, secadora, horno, etc.) Intenta recordar las marcas y modelos si puedes, nos ayudará a estimar su consumo.",
    "Tenemos una heladera grande, un lavarropas automático, una secadora que casi no usamos y un horno eléctrico.",
    "¿Con qué frecuencia usas cada uno de estos electrodomésticos grandes? (a diario, varias veces por semana, etc.)",
    "La heladera está enchufada todo el día, el lavarropas lo usamos como 3 veces por semana, la secadora solo en invierno y el horno, los fines de semana cuando hacemos asado.",
    "¿Tienes aire acondicionado o calefacción central? Si es así, ¿cuántas horas al día lo usas en promedio?",
    "En verano prendemos el aire acondicionado como 4 horas al día, y en invierno usamos el calefactor eléctrico unas 2 horas.",
    "¿Cuántas horas al día tienes encendidas las luces en tu casa?",
    "Las luces, ¡uf!, siempre hay alguien dejando alguna prendida.",
    "¿Tienes muchos cargadores de celular, tablets, etc.? ¿Los dejas conectados aunque no estén cargando?",
    "Tenemos como mil cargadores, los dejamos enchufados siempre porque da lata estar desenchufando y enchufando.",
    "¿Tienes computador de escritorio? ¿Cuántas horas al día lo usas?",
    "Tengo un pc para el trabajo y lo uso como 6 horas en la semana y 1 o 2 los fines de semana.",
    "¿Tienes alguna consola de videojuegos? ¿Con qué frecuencia la usas?",
    "La play la tiene mi hijo, pero no la usa mucho, solo los fines de semana.",
    "¿Cocinas mucho en casa? ¿Utilizas estufa eléctrica, a gas o vitrocerámica?",
    "Cocino todos los días, uso la cocina eléctrica y el horno.",
    "¿Has notado un aumento en tu cuenta de la luz últimamente? Si es así, ¿a qué crees que se debe?",
    "La verdad que no me fijo mucho en la cuenta de la luz, pero últimamente me ha parecido que viene más cara.",
    "¿Tienes alguna idea aproximada de cuánto te llega la cuenta de la luz cada mes?",
    "Ni idea, como 30 lucas, no sé.",
  ];

  final List<String> displayedMessages = [];
  final ScrollController _scrollController = ScrollController();
  List<String> currentWords = [];
  int messageIndex = 0;
  int wordIndex = 0;
  bool _shouldAutoscroll = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _startChat();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _shouldAutoscroll = true; // Re-enable autoscroll if user is at the bottom
      }
    } else {
      _shouldAutoscroll = false; // Disable autoscroll if user scrolls up
    }
  }

  void _startChat() {
    Timer.periodic(Duration(milliseconds: 200), (timer) {
      if (messageIndex < messages.length) {
        final words = messages[messageIndex].split(' ');

        if (wordIndex < words.length) {
          setState(() {
            currentWords.add(words[wordIndex]);
            wordIndex++;
          });
          _scrollToBottom();
        } else {
          setState(() {
            displayedMessages.add(messages[messageIndex]);
            currentWords.clear();
            wordIndex = 0;
            messageIndex++;
          });
          _scrollToBottom();
          timer.cancel();
          Future.delayed(Duration(seconds: 2), () => _startChat());
        }
      } else {
        timer.cancel();
      }
    });
  }

  void _scrollToBottom() {
    if (!_shouldAutoscroll) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: displayedMessages.length + 1,
      itemBuilder: (context, index) {
        if (index < displayedMessages.length) {
          return _buildMessageTile(displayedMessages[index], _isUser1(index));
        } else if (currentWords.isNotEmpty) {
          return _buildCurrentMessageTile(currentWords, _isUser1(index));
        } else {
          return SizedBox.shrink();
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
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0)
          .add(isUser1 ? EdgeInsets.only(right: 80.0) : EdgeInsets.only(left: 80.0)),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isUser1 ? Theme.of(context).colorScheme.secondaryContainer : Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8).subtract(isUser1 ?
              BorderRadius.only(bottomLeft: Radius.circular(8)) :
              BorderRadius.only(bottomRight: Radius.circular(8))
            ),
          ),
          child: Text(
            message,
            textAlign: isUser1 ? TextAlign.left : TextAlign.right,
            style: TextStyle(
              fontSize: 16,
              color: isUser1 ? Theme.of(context).colorScheme.onSecondaryContainer : Theme.of(context).colorScheme.onPrimaryContainer
            )
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentMessageTile(List<String> words, bool isUser1) {
    return _AnimatedMessageTile(
      isUser1: isUser1,
      child: Align(
        alignment: isUser1 ? Alignment.centerLeft : Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0)
            .add(isUser1 ? EdgeInsets.only(right: 80.0) : EdgeInsets.only(left: 80.0)),
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isUser1 ? Theme.of(context).colorScheme.secondaryContainer : Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8).subtract(isUser1 ?
              BorderRadius.only(bottomLeft: Radius.circular(8)) :
              BorderRadius.only(bottomRight: Radius.circular(8))
            ),
            ),
            child: Wrap(
              alignment: isUser1 ? WrapAlignment.start : WrapAlignment.end,
              children: words.map((word) {
                return _AnimatedWord(word: word, isUser1: isUser1);
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedWord extends StatefulWidget {
  final String word;
  final bool isUser1;

  const _AnimatedWord({required this.word, required this.isUser1});

  @override
  State<_AnimatedWord> createState() => _AnimatedWordState();
}

class _AnimatedWordState extends State<_AnimatedWord>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Text(
          widget.word,
          textAlign: widget.isUser1 ? TextAlign.left : TextAlign.right,
          style: TextStyle(
            fontSize: 16,
            color: widget.isUser1 ? Theme.of(context).colorScheme.onSecondaryContainer : Theme.of(context).colorScheme.onPrimaryContainer
          )
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

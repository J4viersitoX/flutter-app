import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class MyIntroScreen extends StatefulWidget {
  const MyIntroScreen({super.key});

  @override
  MyIntroScreenState createState() => MyIntroScreenState();
}

class MyIntroScreenState extends State<MyIntroScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      //titlePadding: EdgeInsets.only(top: 50.0),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
      bodyAlignment: Alignment.center,
    );
    
    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Te damos la bienvenida a",
          bodyWidget: CircleAvatar(
            maxRadius: 160.0,
            child: Container(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lightbulb_outline_rounded, size: 100.0,),
                  Text("<NombreApp>", style: TextStyle(fontSize: 40.0),),
                ],
              ),
            ),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "La 2da pagina",
          body: "el otro cuerpo",
          decoration: pageDecoration,
        )
      ],
      done: const Text('Done!'),
      onDone: () {},
      showNextButton: false,
    );
  }
}

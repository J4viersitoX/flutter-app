import 'package:flutter/material.dart';
import 'package:flutter_app/main_menu.dart';

class MyIntroScreen extends StatefulWidget {
  const MyIntroScreen({super.key});

  @override
  MyIntroScreenState createState() => MyIntroScreenState();
}

class MyIntroScreenState extends State<MyIntroScreen> {
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.sizeOf(context).width;
    // double height = MediaQuery.sizeOf(context).height;
    
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: BoxConstraints.expand(height: Theme.of(context).textTheme.headlineMedium!.fontSize! * 1.1 + 200.0,),
              decoration: BoxDecoration(
                color: Colors.green[400],
                shape: BoxShape.circle,
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lightbulb_outline_rounded, size: 100,),
                  Text("<NombreApp>", style: TextStyle(fontSize: 20),),
                ],
              ),
            ),
            const SizedBox(height: 40.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainMenu()),
                  );
                },
                child: const Expanded(child: Text("Comenzar el recorrido interactivo", style: TextStyle(fontSize: 20), textAlign: TextAlign.center,)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

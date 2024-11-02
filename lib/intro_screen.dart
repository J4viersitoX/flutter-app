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
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Image(
                        image: AssetImage("assets/images/Logo-transparente.png"),
                        fit: BoxFit.contain
                      ),
                    )
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "EnergIA",
                      style: TextStyle(
                        fontSize: 20,
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold
                      )
                    )
                  ),
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
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.primaryContainer)
                ),
                child: Expanded(
                  child: Text(
                    "Comenzar el recorrido interactivo",
                    style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.onPrimaryContainer),
                    textAlign: TextAlign.center
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/lista_aparatos.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuResumen extends StatefulWidget {
  const MenuResumen({super.key});

  @override
  _MenuResumenState createState() => _MenuResumenState();
}

class _MenuResumenState extends State<MenuResumen> {
  @override
  Widget build(BuildContext context) {
    final gridBtnStyle = ButtonStyle(
                  fixedSize: const WidgetStatePropertyAll<Size>(
                    Size.fromHeight(100.0)
                  ),
                  shape: const WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))
                    )
                  ),
                  textStyle: const WidgetStatePropertyAll(
                    TextStyle(fontSize: 16.0, ),
                  ),
                  foregroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.onPrimaryContainer),
                  backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.primaryContainer)
                );
    final vpSize = MediaQuery.of(context).size;
    return ListView(
      children: [
        Card(
          margin: const EdgeInsets.all(12.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: SvgPicture.asset("assets/images/Carita Muerta.svg"),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text(
                        "Mal consumo eléctrico!!!",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 19.0, color: Theme.of(context).colorScheme.onPrimaryContainer)
                      ),
                      IconButton(
                        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                        onPressed: () {},
                        icon: SizedBox(
                          width: 160.0,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  "Ver acciones\npendientes",
                                  style: TextStyle(fontSize: 17.0, color: Theme.of(context).colorScheme.onPrimaryContainer),
                                ),
                              ),
                              Expanded(
                                child: Icon(
                                  Icons.arrow_right,
                                  color: Theme.of(context).colorScheme.onPrimaryContainer
                                )
                              ),
                            ],
                          ),
                        )
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  style: gridBtnStyle,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ListaAparatos()),
                    );
                  },
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.devices),
                      Text("Ver aparatos\nregistrados", textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  style: gridBtnStyle,
                  onPressed: () {},
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.add_box_rounded),
                      Text("Añadir aparatos", textAlign: TextAlign.center)
                    ],
                  )
                ),
              ),
            )
          ]
        )
      ],
    );
  }
}

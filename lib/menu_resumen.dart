import 'package:flutter/material.dart';
import 'package:flutter_app/lista_aparatos.dart';

class MenuResumen extends StatefulWidget {
  const MenuResumen({super.key});

  @override
  _MenuResumenState createState() => _MenuResumenState();
}

class _MenuResumenState extends State<MenuResumen> {
  final _gridBtnStyle = const ButtonStyle(
                    fixedSize: WidgetStatePropertyAll<Size>(
                      Size.fromHeight(100.0)
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))
                      )
                    ),
                    textStyle: WidgetStatePropertyAll(
                      TextStyle(fontSize: 16.0, ),
                    ),
                  );

  @override
  Widget build(BuildContext context) {
    final vpSize = MediaQuery.of(context).size;
    return ListView(
      children: [
        Card(
          margin: const EdgeInsets.all(12.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.tag_faces,
                  color: Colors.red,
                  size: vpSize.width * 0.3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const Text("Mal consumo eléctrico!!!", style: TextStyle(fontSize: 19.0),),
                    IconButton(
                      padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
                      onPressed: () {},
                      icon: const SizedBox(
                        width: 160.0,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                "Ver acciones\npendientes",
                                style: TextStyle(fontSize: 17.0),
                              ),
                            ),
                            Expanded(child: Icon(Icons.arrow_right)),
                          ],
                        ),
                      )
                    )
                  ],
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
                  style: _gridBtnStyle,
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
                  style: _gridBtnStyle,
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

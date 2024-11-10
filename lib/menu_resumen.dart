import 'package:flutter/material.dart';
import 'package:flutter_app/lista_aparatos.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EstadoEnergia extends StatelessWidget {
  const EstadoEnergia({
    super.key,
    required this.icon,
    required this.title,
    required this.body
  });

  final String icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Card(
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
                child: SvgPicture.asset(icon),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 19.0,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    const SizedBox(height: 10),
                    Text(
                      body,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Theme.of(context).colorScheme.onPrimaryContainer
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuResumen extends StatefulWidget {
  const MenuResumen({super.key});

  @override
  _MenuResumenState createState() => _MenuResumenState();
}

class _MenuResumenState extends State<MenuResumen> {
  final _estados = <EstadoEnergia>[
    const EstadoEnergia(
      icon: "assets/images/Carita Feli.svg",
      title: "¡Excelente Trabajo!",
      body: "Su consumo de energía es óptimo",
    ),
    const EstadoEnergia(
      icon: "assets/images/Carita Seria.svg",
      title: "Sugerencia",
      body: "Su consumo de energía puede mejorar",
    ),
    const EstadoEnergia(
      icon: "assets/images/Carita Muerta.svg",
      title: "¡Advertencia!",
      body: "Su consumo de energía tiene mucho margen de mejora",
    ),
  ];

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
        _estados[0],
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

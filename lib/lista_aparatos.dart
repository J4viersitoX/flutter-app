import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemAparato extends StatelessWidget {
  const ItemAparato({
    super.key,
    required this.rank,
    required this.tipo,
    required this.imgPath,
    required this.modelo,
    required this.potencia,
    required this.hrsSemana,
    required this.costoMes
  });

  final int rank;
  final String tipo;
  final String imgPath;
  final String modelo;
  final int potencia;
  final double hrsSemana;
  final double costoMes;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0))
              ),
              height: 40,
              child: Row(
                children: [
                  SizedBox(
                      width: 40,
                      child: Center(
                        child: Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(13)
                          ),
                          child: Center(
                            child: Text(
                              "$rank",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.primary
                              ),
                            ),
                          ),
                        )
                      )
                    ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 26,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(13.0)),
                            color: Theme.of(context).colorScheme.surface
                          ),
                          child: Text(tipo, style: const TextStyle(fontSize: 18),)
                        )
                      )
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16.0))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 120,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          imgPath,
                          colorFilter: ColorFilter.mode(
                            Theme.of(context).colorScheme.onSurface,
                            BlendMode.srcIn
                          )
                        ),
                      )
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text("$modelo\n$potencia W • $hrsSemana h/sem", textAlign: TextAlign.center,)
                  ),
                  Expanded(
                    flex: 1,
                    child: Text("\$$costoMes\nCLP", textAlign: TextAlign.center,)
                  )
                ],
              ),
            )
          ],
        ));
  }
}

class ListaAparatos extends StatefulWidget {
  const ListaAparatos({super.key});

  @override
  State<ListaAparatos> createState() => _ListaAparatosState();
}

class _ListaAparatosState extends State<ListaAparatos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista Aparatos"),
      ),
      body: ListView(
        children: <ItemAparato>[
          ItemAparato(
            imgPath: "assets/images/refrigerator-2-svgrepo-com.svg",
            potencia: 150,
            costoMes: 5000,
            hrsSemana: 168,
            modelo: "Samsung galaxy refri+ ultra max",
            rank: 1,
            tipo: "Refrigerador",
          ),
          ItemAparato(
            imgPath: "assets/images/television-svgrepo-com.svg",
            potencia: 40,
            costoMes: 2000,
            hrsSemana: 30,
            modelo: "LG Tele+ OLED UltraHD 4k 90'",
            rank: 2,
            tipo: "Televisor",
          ),
          ItemAparato(
            imgPath: "assets/images/washing-machine-2-svgrepo-com.svg",
            potencia: 200,
            costoMes: 1500,
            hrsSemana: 10,
            modelo: "LG LavaMAX Turbo+ Ultra",
            rank: 3,
            tipo: "Lavadora",
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemAparato extends StatefulWidget {
  const ItemAparato({
    super.key,
    required this.costoMes,
    required this.hrsSemana,
    required this.imgPath,
    required this.modelo,
    required this.potencia,
    required this.tipo
  });
  
  final String tipo;
  final String imgPath;
  final String modelo;
  final int potencia;
  final double hrsSemana;
  final double costoMes;

  @override
  State<ItemAparato> createState() => _ItemAparatoState();
}

class _ItemAparatoState extends State<ItemAparato> with TickerProviderStateMixin {
  bool isExpanded = false;

  late final AnimationController _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500)
    );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                if (isExpanded) {
                  _controller.reverse();
                } else {
                  _controller.forward();
                }
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: isExpanded ? const BorderRadius.vertical(top: Radius.circular(16.0)) : BorderRadius.circular(16.0)
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
                              child: Icon(Icons.arrow_drop_down_outlined, color: Theme.of(context).colorScheme.primary),
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
                            child: Text(widget.tipo, style: const TextStyle(fontSize: 18),)
                          )
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: 26,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(13.0)),
                            color: Theme.of(context).colorScheme.surfaceContainerHighest
                          ),
                          child: Text("+ \$${widget.costoMes} CLP", style: const TextStyle(fontSize: 16))
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizeTransition(
              sizeFactor: CurvedAnimation(
                curve: Curves.fastOutSlowIn,
                parent: _controller,
              ),
              child: Container(
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
                            widget.imgPath,
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).colorScheme.onSurface,
                              BlendMode.srcIn
                            )
                          ),
                        )
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        "${widget.modelo}\n${widget.potencia} W • ${widget.hrsSemana} h/semana",
                        textAlign: TextAlign.center,
                        style: const TextStyle(height: 2)
                      )
                    ),
                  ],
                ),
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
        children: const <ItemAparato>[
          ItemAparato(
            imgPath: "assets/images/refrigerator-2-svgrepo-com.svg",
            potencia: 150,
            costoMes: 5000,
            hrsSemana: 168,
            modelo: "Samsung galaxy refri+ ultra max",
            tipo: "Refrigerador",
          ),
          ItemAparato(
            imgPath: "assets/images/television-svgrepo-com.svg",
            potencia: 40,
            costoMes: 2000,
            hrsSemana: 30,
            modelo: "LG Tele+ OLED UltraHD 4k 90'",
            tipo: "Televisor",
          ),
          ItemAparato(
            imgPath: "assets/images/washing-machine-2-svgrepo-com.svg",
            potencia: 200,
            costoMes: 1500,
            hrsSemana: 10,
            modelo: "LG LavaMAX Turbo+ Ultra",
            tipo: "Lavadora",
          )
        ],
      ),
    );
  }
}

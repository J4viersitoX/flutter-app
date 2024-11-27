import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemAparato extends StatefulWidget {
  ItemAparato({
    super.key,
    required this.costoMes,
    required this.hrsSemana,
    required this.imgPath,
    required this.modelo,
    required this.potencia,
    required this.tipo,
    this.isExpanded = false
  });
  
  final String tipo;
  final String imgPath;
  final String modelo;
  final int potencia;
  final double hrsSemana;
  final double costoMes;
  bool isExpanded;

  @override
  State<ItemAparato> createState() => _ItemAparatoState();
}

class _ItemAparatoState extends State<ItemAparato> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500)
  );

  @override
  void initState() {
    super.initState();
    if (widget.isExpanded) {
      _controller.forward();
    }
  }

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
                if (widget.isExpanded) {
                  _controller.reverse();
                } else {
                  _controller.forward();
                }
                setState(() {
                  widget.isExpanded = !widget.isExpanded;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: widget.isExpanded ? const BorderRadius.vertical(top: Radius.circular(16.0)) : BorderRadius.circular(16.0)
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
        actions: [
          IconButton(
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => Dialog(
                  insetPadding: const EdgeInsets.all(24.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            ItemAparato(
                              imgPath: "assets/images/refrigerator-2-svgrepo-com.svg",
                              potencia: 1,
                              costoMes: 1,
                              hrsSemana: 1,
                              modelo: "Modelo",
                              tipo: "Aparato",
                              isExpanded: true,
                            ),
                            const SizedBox(
                              height: 200,
                            )
                          ]
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cerrar"),
                        )
                      ],
                    ),
                  )
                )
              );
            },
            icon: const Icon(Icons.question_mark_rounded)
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: <ItemAparato>[
          ItemAparato(
            imgPath: "assets/images/refrigerator-2-svgrepo-com.svg",
            potencia: 150,
            costoMes: 1500,
            hrsSemana: 168,
            modelo: "Samsung galaxy refri+ ultra max",
            tipo: "Refrigerador",
          ),
          ItemAparato(
            imgPath: "assets/images/washing-machine-2-svgrepo-com.svg",
            potencia: 1000,
            costoMes: 500,
            hrsSemana: 3,
            modelo: "LG LavaMAX Turbo+ Ultra",
            tipo: "Lavadora",
          ),
          ItemAparato(
            imgPath: "assets/images/washing-machine-2-svgrepo-com.svg",
            potencia: 2000,
            costoMes: 200,
            hrsSemana: 1,
            modelo: "LG LavaMAX Turbo+ Ultra",
            tipo: "Secadora",
          ),
          ItemAparato(
            imgPath: "assets/images/stove-svgrepo-com.svg",
            potencia: 2500,
            costoMes: 300,
            hrsSemana: 2,
            modelo: "LG LavaMAX Turbo+ Ultra",
            tipo: "Horno",
          ),
          ItemAparato(
            imgPath: "assets/images/fan-2-svgrepo-com.svg",
            potencia: 1500,
            costoMes: 2500,
            hrsSemana: 20,
            modelo: "LG LavaMAX Turbo+ Ultra",
            tipo: "Ventilador",
          ),
          ItemAparato(
            imgPath: "assets/images/radiator-heat-svgrepo-com.svg",
            potencia: 1500,
            costoMes: 1500,
            hrsSemana: 10,
            modelo: "LG LavaMAX Turbo+ Ultra",
            tipo: "Calefactor",
          ),
          ItemAparato(
            imgPath: "assets/images/television-svgrepo-com.svg",
            potencia: 300,
            costoMes: 500,
            hrsSemana: 30,
            modelo: "LG LavaMAX Turbo+ Ultra",
            tipo: "Computador",
          ),
          ItemAparato(
            imgPath: "assets/images/console-joystick-gaming-svgrepo-com.svg",
            potencia: 250,
            costoMes: 200,
            hrsSemana: 10,
            modelo: "LG LavaMAX Turbo+ Ultra",
            tipo: "Consola",
          ),
          ItemAparato(
            imgPath: "assets/images/lamp-1-svgrepo-com.svg",
            potencia: 600,
            costoMes: 10000,
            hrsSemana: 140,
            modelo: "LG LavaMAX Turbo+ Ultra",
            tipo: "Luces",
          ),
          ItemAparato(
            imgPath: "assets/images/usb-charger-wire-svgrepo-com.svg",
            potencia: 25,
            costoMes: 250,
            hrsSemana: 168,
            modelo: "LG LavaMAX Turbo+ Ultra",
            tipo: "Cargadores",
          ),
        ],
      ),
    );
  }
}

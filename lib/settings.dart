import 'package:flutter/material.dart';
import 'package:flutter_app/theme.dart';

class Settings extends StatefulWidget {
  const Settings({ super.key });

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool theme = true;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Opciones'),
        
      ),
      body: ListView(
        padding: const EdgeInsets.all(1),
        children: <Widget>[
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10),
                height: 50,
                color: Colors.white,
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Modo oscuro'
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Switch(
                    // This bool value toggles the switch.
                    value: theme,
                    activeColor: Colors.grey,
                    onChanged: (bool value) {
                      // This is called when the user toggles the switch.
                      setState(() {
                        theme = value;
                      });
                    },
                  )
                
                )
              )
            ] 
          ),
          
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10),
                height: 50,
                color: Colors.white,
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Formato de unidades'
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10),
                height: 50,
                color: Colors.white,
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Comuna'
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10),
                height: 50,
                color: Colors.white,
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Formato de unidades'
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


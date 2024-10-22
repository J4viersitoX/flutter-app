import 'package:flutter/material.dart';
import 'main.dart';

class Settings extends StatefulWidget {
  const Settings({ super.key });

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool prendio = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Opciones'),
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
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Modo oscuro'
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10),
                child: Switch(
                  value: prendio,
                  onChanged: (bool value){
                    setState(() {
                      prendio = value;
                    });
                    if (value){
                      MyApp.of(context).changeTheme(ThemeMode.dark);
                    }
                    else {
                      MyApp.of(context).changeTheme(ThemeMode.light);
                    }
                  }
                )
              ),
            ]
          )
        ] 
      ),
    );
  }
}


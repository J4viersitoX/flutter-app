import 'package:flutter/material.dart';

class MenuResumen extends StatefulWidget {
  const MenuResumen({super.key});

  @override
  _MenuResumenState createState() => _MenuResumenState();
}

class _MenuResumenState extends State<MenuResumen> {
  @override
  Widget build(BuildContext context) {
    final _vpSize = MediaQuery.of(context).size;
    return ListView(
      children: [
        Card(
          child: ListTile(
            leading: Icon(
              Icons.tag_faces,
              color: Colors.red,
              size: _vpSize.width * 0.6,
            ),
            title: TextButton(
                onPressed: () {},
                child: Text(
                  "Ver acciones pendientes",
                  style: TextStyle(fontSize: 17.0),
                ))
          ),
        ),
      ],
    );
  }
}

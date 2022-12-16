import 'package:flutter/material.dart';

class ToolTileView extends StatelessWidget {

  final String title;
  final IconData icon;
  final Widget targetPage;

  const ToolTileView(this.title, this.icon, this.targetPage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        leading: Icon(icon),
        iconColor: Colors.black,
        tileColor: Colors.grey,
        contentPadding: const EdgeInsets.all(15.0),
        title: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
        style: ListTileStyle.list,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => targetPage));
        },
      ),
    );
  }
}
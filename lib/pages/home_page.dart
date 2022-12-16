import 'package:flutter/material.dart';
import 'package:useful_toolbox/tools.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[600],
        title: const Center(
          child: Text(
            '好用工具箱',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: toolsView.length,
        itemBuilder: ((context, index) {
          return toolsView[index];
        }),
      ),
    );
  }
}

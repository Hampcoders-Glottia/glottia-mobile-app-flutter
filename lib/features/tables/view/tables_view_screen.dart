import 'package:flutter/material.dart';

class TablesViewScreen extends StatelessWidget {
  const TablesViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vista del Local'),
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black87,
      ),
      body: const Center(
        child: Text(
          'Aquí puedes gestionar las mesas del establecimiento.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
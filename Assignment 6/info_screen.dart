import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Page"),
        backgroundColor: Colors.deepPurple,
      ),
      body: const Center(
        child: Text(
          "This is the About Page.",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}

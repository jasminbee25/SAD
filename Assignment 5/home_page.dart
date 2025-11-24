import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Home Page",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(onPressed: (){}, icon: const Icon(Icons.home, color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings, color: Colors.white),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          "Welcome!",
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
      ),
    );
  }
}

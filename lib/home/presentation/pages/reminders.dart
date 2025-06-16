import 'package:flutter/material.dart';

class RemindersPage extends StatelessWidget{

  const RemindersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reminders")),
      body: Center(child: Text("aqui va todo lo de Reminders")),
    );
  }

}
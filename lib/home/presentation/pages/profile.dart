import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget{
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Elder Profile")),
      body: Center(child: Text("Aqui va la info de elder profile")),
    );
  }

}
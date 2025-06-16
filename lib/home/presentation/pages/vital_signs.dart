
import 'package:flutter/material.dart';

class VitalSignsPage extends StatelessWidget {
  const VitalSignsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Vital Signs")),
      body: Center(child: Text("Aquí va el panel de signos vitales")),
    );
  }
}
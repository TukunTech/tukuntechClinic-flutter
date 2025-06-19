import 'package:flutter/material.dart';
import 'package:tukuntech/core/widgets/bottom_nav_bar.dart';

class BaseScreen extends StatelessWidget {
  final Widget child;
  final int currentIndex;

  const BaseScreen({
    super.key,
    required this.child,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: child),
      bottomNavigationBar: BottomBar(currentIndex: currentIndex),
    );
  }
}

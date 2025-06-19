import 'package:flutter/material.dart';
import 'package:tukuntech/features/emergency_numbers/presentation/pages/emergency_numbers_page.dart';
import 'package:tukuntech/features/vital_signs/presentation/pages/vital_signs_page.dart';
import 'package:tukuntech/features/profile/presentation/pages/profile.dart';
import 'package:tukuntech/home/presentation/pages/home_page.dart';
import 'package:tukuntech/home/presentation/pages/reminders.dart';

class BottomBar extends StatelessWidget {
  final int currentIndex;

  const BottomBar({super.key, required this.currentIndex});

  void _navigate(BuildContext context, int index) {
    if (index == currentIndex) return;
    switch (index) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
        break;
      case 1:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const VitalSignsPage()));
        break;
      case 2:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const RemindersPage()));
        break;
      case 3:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ElderProfilePage()));
        break;
      case 4:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const EmergencyNumbersPage()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    const activeColor = Color(0xFF18BFE8);
    const inactiveColor = Colors.grey;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _navItem(context, icon: Icons.home, index: 0, label: 'Home', activeColor: activeColor, inactiveColor: inactiveColor),
          _navItem(context, icon: Icons.monitor_heart, index: 1, label: 'Vitals', activeColor: activeColor, inactiveColor: inactiveColor),
          _navItem(context, icon: Icons.alarm, index: 2, label: 'Reminders', activeColor: activeColor, inactiveColor: inactiveColor),
          _navItem(context, icon: Icons.person, index: 3, label: 'Profile', activeColor: activeColor, inactiveColor: inactiveColor),
          _navItem(context, icon: Icons.phone, index: 4, label: 'Emergency', activeColor: activeColor, inactiveColor: inactiveColor),
        ],
      ),
    );
  }

  Widget _navItem(
    BuildContext context, {
    required IconData icon,
    required int index,
    required String label,
    required Color activeColor,
    required Color inactiveColor,
  }) {
    final bool isActive = index == currentIndex;
    return GestureDetector(
      onTap: () => _navigate(context, index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? activeColor.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isActive ? activeColor : inactiveColor, size: 26),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? activeColor : inactiveColor,
                fontSize: 12,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            )
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class VitalBox extends StatelessWidget {
  final String label;
  final String waveText;
  final String valueText;
  final Color color;

  const VitalBox({
    super.key,
    required this.label,
    required this.waveText,
    required this.valueText,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFEFEFEF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(waveText, style: const TextStyle(fontFamily: 'monospace')),
            ],
          ),
          Text(valueText, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}

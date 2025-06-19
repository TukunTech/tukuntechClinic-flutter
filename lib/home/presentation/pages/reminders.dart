import 'package:flutter/material.dart';
import 'package:tukuntech/core/widgets/base_screen.dart';

class RemindersPage extends StatelessWidget {
  const RemindersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final yellow = const Color(0xFFFFD700);
    final cyan = const Color(0xFF00BCD4);

    return BaseScreen(
      currentIndex: 2,
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.black),
            ),
            title: const Text("Reminders", style: TextStyle(color: Colors.black)),
            centerTitle: true,
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/logo.png'),
                  radius: 18,
                ),
              )
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: yellow,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.access_time_filled, color: Colors.blue),
                        SizedBox(width: 8),
                        Text("Pending Medications", style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  _buildMedicationCard("Medicine 01", "12:00", "Ready"),
                  _buildMedicationCard("Medicine 01", "16:00", "Ready"),
                  _buildMedicationCard("Medicine 01", "19:00", "Ready"),
                  _buildMedicationCard("Medicine 01", "22:00", "Ready"),

                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: cyan,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      "Medications Taken",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),

                  _buildMedicationCard("Medicine 03", "09:00", "Earring"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationCard(String name, String time, String status) {
    final isTaken = status == "Earring";
    final statusColor = isTaken ? Colors.grey[300] : Colors.cyan[100];
    final textColor = isTaken ? Colors.grey[700] : Colors.teal;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text("$name  Take at $time"),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(status, style: TextStyle(color: textColor)),
        ),
      ),
    );
  }
}

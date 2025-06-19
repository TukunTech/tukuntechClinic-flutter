import 'package:flutter/material.dart';

class RemindersPage extends StatelessWidget{

  const RemindersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final yellow = Color(0xFFFFD700);
    final cyan = Color(0xFF00BCD4);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black)
        ),
        title: Text("Reminders", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/logo.png'), 
              radius: 18,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //TODO: Pending Medications API
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: yellow,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.access_time_filled, color: Colors.blue),
                  SizedBox(width: 8),
                  Text("Pending Medications",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(height: 10),

            //TODO: Lista de medicamentos pendientes API
            _buildMedicationCard("Medicine 01", "12:00", "Ready"),
            _buildMedicationCard("Medicine 01", "16:00", "Ready"),
            _buildMedicationCard("Medicine 01", "19:00", "Ready"),
            _buildMedicationCard("Medicine 01", "22:00", "Ready"),

            SizedBox(height: 20),

            //TODO: Medications Taken API
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: cyan,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "Medications Taken",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            SizedBox(height: 10),

            _buildMedicationCard("Medicine 03", "09:00", "Earring"),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: ''),
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
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
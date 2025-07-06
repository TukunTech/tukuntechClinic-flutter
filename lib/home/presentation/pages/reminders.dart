import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tukuntech/core/widgets/base_screen.dart';
import 'package:tukuntech/core/widgets/bottom_nav_bar.dart';
import 'package:tukuntech/features/medicationsTaken/blocs/medication_taken_bloc.dart';
import 'package:tukuntech/features/medicationsTaken/blocs/medication_taken_event.dart';
import 'package:tukuntech/features/medicationsTaken/blocs/medication_taken_state.dart';
import 'package:tukuntech/features/medicationsTaken/domain/entities/medication_taken.dart';
import 'package:tukuntech/features/pendingMedications/data/datasources/pendingMedications_service.dart';
import 'package:tukuntech/features/pendingMedications/domain/entities/PendingMedications.dart';
import 'package:tukuntech/features/pendingMedications/domain/entities/TimeToTake.dart';

class RemindersPage extends StatefulWidget {
  const RemindersPage({super.key});

  @override
  State<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  List<PendingMedications> _pendingMedications = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
    context.read<MedicationTakenBloc>().add(GetAllMedicationTakenEvent());
  }

  Future<void> loadData() async {
    final data = await PendingMedicationsService().getPendingMedications();
    setState(() {
      _pendingMedications = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final yellow = Color(0xFFFFD700);
    final cyan = Color(0xFF00BCD4);

    return BaseScreen(
      currentIndex: 2, // Index de Reminders en BottomBar
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: yellow,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.access_time_filled, color: Colors.blue),
                          SizedBox(width: 8),
                          Text("Pending Medications",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    ..._pendingMedications.map((med) {
                      final times = med.timeToTake.isNotEmpty
                          ? med.timeToTake
                          : [TimeToTake(hour: 0, minute: 0, second: 0, nano: 0)];
                      return times.map((time) {
                        final formattedTime =
                            "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
                        final statusText = med.status.isNotEmpty
                            ? med.status.first.status
                            : "Unknown";
                        final name = med.medicineName.isNotEmpty
                            ? med.medicineName
                            : "Unnamed";
                        return GestureDetector(
                          onTap: () {
                            if (statusText.toLowerCase() != 'pending') {
                              final medication = MedicationTaken(
                                id: 0,
                                medicineName: name,
                                dosage: med.dosage.isNotEmpty
                                    ? med.dosage
                                    : "Sin dosis",
                                status: med.status,
                                timeToTake: [time],
                              );
                              context.read<MedicationTakenBloc>().add(
                                    AddMedicationTakenEvent(
                                        medicationTaken: medication),
                                  );
                              setState(() {
                                _pendingMedications = _pendingMedications
                                    .where((m) => m.id != med.id)
                                    .toList();
                              });
                            }
                          },
                          child: _buildMedicationCard(
                              name, formattedTime, statusText),
                        );
                      }).toList();
                    }).expand((e) => e),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: cyan,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "Medications Taken",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<MedicationTakenBloc, MedicationTakenState>(
                      builder: (context, state) {
                        if (state is LoadedMedicationTakenState) {
                          return Column(
                            children: state.medicationTaken.map((med) {
                              final time = med.timeToTake.first;
                              final formattedTime =
                                  "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
                              return GestureDetector(
                                onTap: () {
                                  context.read<MedicationTakenBloc>().add(
                                        RemoveMedicationTakenEvent(id: med.id),
                                      );
                                },
                                child: _buildMedicationCard(
                                    med.medicineName, formattedTime, "Taken"),
                              );
                            }).toList(),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildMedicationCard(String name, String time, String status) {
    final isTaken = status.toLowerCase() == "pending";
    final statusColor = isTaken ? Colors.grey[300] : Colors.cyan[100];
    final textColor = isTaken ? Colors.grey[700] : Colors.teal;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text("$name  •  Take at $time"),
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

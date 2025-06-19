import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tukuntech/core/widgets/base_screen.dart';
import 'package:tukuntech/features/vital_signs/data/datasources/vital_signs_service.dart';
import 'package:tukuntech/features/vital_signs/presentation/blocs/vital_signs_bloc.dart';
import 'package:tukuntech/features/vital_signs/presentation/blocs/vital_signs_event.dart';
import 'package:tukuntech/features/vital_signs/presentation/blocs/vital_signs_state.dart';
import 'package:tukuntech/features/vital_signs/presentation/widgets/vital_box.dart';

class VitalSignsPage extends StatelessWidget {
  const VitalSignsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VitalSignsBloc(VitalSignsService())..add(LoadVitalSigns()),
      child: BaseScreen(
        currentIndex: 1,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, size: 20),
                    label: const Text("return"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF18BFE8),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                  ),
                  Image.asset("assets/logo.png", height: 40),
                ],
              ),
            ),
            const Text(
              'Vital Signs Panel',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<VitalSignsBloc, VitalSignsState>(
                builder: (context, state) {
                  if (state is VitalSignsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is VitalSignsLoaded) {
                    final data = state.vitalSign;
                    final elder = data.elder;

                    return Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '${elder.name} ${elder.lastName}',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 12),
                              VitalBox(
                                label: "HR",
                                waveText: "▁▂▃▄▅▄▃▂▁▂▄▆▄▂▁",
                                valueText: "${data.hr} bpm",
                                color: Colors.red,
                              ),
                              VitalBox(
                                label: "NIBP",
                                waveText: "▁▄▅▇▆▃▁▂▃▄▅▄▃",
                                valueText: "${data.nipb} mmHg",
                                color: Colors.green,
                              ),
                              VitalBox(
                                label: "SpO2",
                                waveText: "▁▁▃▄▃▂▂▃▄▅▄▃▁",
                                valueText: "${data.sp02} %",
                                color: Colors.blue,
                              ),
                              VitalBox(
                                label: "Temp",
                                waveText: "▁▂▃▄▃▂▁▁▂▃▃▄▃",
                                valueText: "${data.temp.toStringAsFixed(1)} °C",
                                color: Colors.grey.shade700,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text('Alerts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const ListTile(
                            leading: Icon(Icons.warning, color: Colors.white),
                            title: Text(
                              'There are no alerts',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (state is VitalSignsError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

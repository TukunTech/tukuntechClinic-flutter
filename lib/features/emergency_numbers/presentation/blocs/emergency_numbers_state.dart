import '../../domain/entities/emergency_numbers.dart';


class EmergencyNumbersState {
  final List<EmergencyContact> familyContacts;
  final List<EmergencyContact> emergencyServices;
  final bool isLoading;

  EmergencyNumbersState({
    required this.familyContacts,
    required this.emergencyServices,
    this.isLoading = false,
  });

  EmergencyNumbersState.initial()
      : familyContacts = [],
        emergencyServices = [],
        isLoading = false;
}

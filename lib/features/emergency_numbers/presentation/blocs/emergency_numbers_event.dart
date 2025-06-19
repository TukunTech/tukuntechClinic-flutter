import '../../domain/entities/emergency_numbers.dart';

abstract class EmergencyNumbersEvent {}

class LoadEmergencyContacts extends EmergencyNumbersEvent {}

class AddEmergencyContact extends EmergencyNumbersEvent {
  final EmergencyContact contact;
  AddEmergencyContact(this.contact);
}

class DeleteEmergencyContact extends EmergencyNumbersEvent {
  final int id;
  DeleteEmergencyContact(this.id);
}

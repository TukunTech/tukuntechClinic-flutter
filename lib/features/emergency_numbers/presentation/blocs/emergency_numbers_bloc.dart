import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/emergency_numbers.dart';
import '../../data/datasources/emergency_numbers_service.dart';
import '../../data/models/emergency_numbers_dto.dart';
import 'emergency_numbers_event.dart';
import 'emergency_numbers_state.dart';

class EmergencyNumbersBloc extends Bloc<EmergencyNumbersEvent, EmergencyNumbersState> {
  final EmergencyNumbersService service;

  EmergencyNumbersBloc({required this.service})
      : super(EmergencyNumbersState.initial()) {
    on<LoadEmergencyContacts>(_onLoadEmergencyContacts);
    on<AddEmergencyContact>(_onAddEmergencyContact);
    on<DeleteEmergencyContact>(_onDeleteEmergencyContact);
  }

  void _onLoadEmergencyContacts(
      LoadEmergencyContacts event,
      Emitter<EmergencyNumbersState> emit,
      ) async {
    emit(EmergencyNumbersState(
      familyContacts: state.familyContacts,
      emergencyServices: state.emergencyServices,
      isLoading: true,
    ));

    print('[Bloc] Cargando contactos...');

    try {
      final dtos = await service.fetchEmergencyContacts();
      print('[Bloc] Respuesta recibida: ${dtos.length} contactos');

      final contacts = dtos
          .map((dto) => EmergencyContact(
        id: dto.id,
        name: dto.contactName,
        phone: dto.number,
      ))
          .toList();

      emit(EmergencyNumbersState(
        familyContacts: contacts,
        emergencyServices: [
          EmergencyContact(id: 0, name: 'Ambulance', phone: '123456789'),
          EmergencyContact(id: 1, name: 'Hospital', phone: '123456789'),
        ],
        isLoading: false,
      ));

      print('[Bloc] Estado cargado con ${contacts.length} contactos.');
    } catch (e, stack) {
      print('[Bloc] Error al cargar: $e');
      print('[Bloc] Stacktrace:\n$stack');

      emit(EmergencyNumbersState(
        familyContacts: [],
        emergencyServices: [],
        isLoading: false,
      ));
    }
  }

  void _onAddEmergencyContact(
      AddEmergencyContact event,
      Emitter<EmergencyNumbersState> emit,
      ) async {
    try {
      print('[Bloc] Iniciando POST de contacto...');

      final dto = EmergencyContactDto(
        id: 0,
        number: event.contact.phone,
        contactName: event.contact.name,
      );

      await service.addEmergencyContact(dto);
      print('[Bloc] POST exitoso, recargando lista...');

      final dtos = await service.fetchEmergencyContacts();
      print('[Bloc] Datos después del POST: ${dtos.length} contactos');

      final contacts = dtos
          .map((dto) => EmergencyContact(
        id: dto.id,
        name: dto.contactName,
        phone: dto.number,
      ))
          .toList();

      emit(EmergencyNumbersState(
        familyContacts: contacts,
        emergencyServices: state.emergencyServices,
      ));

      print('[Bloc] Estado actualizado con nuevos contactos.');
    } catch (e, stack) {
      print('[Bloc] Error al agregar contacto: $e');
      print('[Bloc] Stacktrace:\n$stack');
    }
  }

  void _onDeleteEmergencyContact(
      DeleteEmergencyContact event,
      Emitter<EmergencyNumbersState> emit,
      ) async {
    try {
      print('[Bloc] Eliminando contacto con ID: ${event.id}');

      await service.deleteEmergencyContact(event.id);

      final dtos = await service.fetchEmergencyContacts();
      print('[Bloc] Lista después de DELETE: ${dtos.length} contactos');

      final contacts = dtos
          .map((dto) => EmergencyContact(
        id: dto.id,
        name: dto.contactName,
        phone: dto.number,
      ))
          .toList();

      emit(EmergencyNumbersState(
        familyContacts: contacts,
        emergencyServices: state.emergencyServices,
      ));

      print('[Bloc] Contacto eliminado y estado actualizado.');
    } catch (e, stack) {
      print('[Bloc] Error al eliminar contacto: $e');
      print('[Bloc] Stacktrace:\n$stack');
    }
  }
}

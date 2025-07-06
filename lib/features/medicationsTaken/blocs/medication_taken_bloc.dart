import 'package:tukuntech/features/medicationsTaken/blocs/medication_taken_event.dart';
import 'package:tukuntech/features/medicationsTaken/blocs/medication_taken_state.dart';
import 'package:tukuntech/features/medicationsTaken/repositories/medication_taken_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MedicationTakenBloc extends Bloc<MedicationTakenEvent, MedicationTakenState> {
  final MedicationTakenRepository _repository = MedicationTakenRepository();

  MedicationTakenBloc() : super(InitialMedicationTakenState()){
    on<AddMedicationTakenEvent>((event, emit) async{
      await _repository.insertMedicationTaken(event.medicationTaken);
      final medications = await _repository.fetchAll();
      emit(LoadedMedicationTakenState(medicationTaken: medications));
    });
    on<RemoveMedicationTakenEvent>((event, emit) async {
      await _repository.deleteMedicationTaken(event.id);
      final medications = await _repository.fetchAll();
      emit(LoadedMedicationTakenState(medicationTaken: medications));
    });
    on<GetAllMedicationTakenEvent>((event, emit) async {
      final medications = await _repository.fetchAll();
      emit(LoadedMedicationTakenState(medicationTaken: medications));
    });
  }


}
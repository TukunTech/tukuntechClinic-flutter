import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tukuntech/features/vital_signs/data/datasources/vital_signs_service.dart';
import 'vital_signs_event.dart';
import 'vital_signs_state.dart';

class VitalSignsBloc extends Bloc<VitalSignsEvent, VitalSignsState> {
  final VitalSignsService service;

  VitalSignsBloc(this.service) : super(VitalSignsInitial()) {
    on<LoadVitalSigns>((event, emit) async {
      emit(VitalSignsLoading());
      try {
        final dto = await service.fetchLatestVitalSigns();
        emit(VitalSignsLoaded(dto));
      } catch (_) {
        emit(VitalSignsError('No se pudieron cargar los signos vitales'));
      }
    });
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'elder_event.dart';
import 'elder_state.dart';
import '../../data/datasources/elder_service.dart';

class ElderBloc extends Bloc<ElderEvent, ElderState> {
  final ElderService service;

  ElderBloc(this.service) : super(ElderInitial()) {
    on<LoadElder>((event, emit) async {
      emit(ElderLoading());
      try {
        final elder = await service.fetchElder();
        emit(ElderLoaded(elder));
      } catch (e) {
        emit(ElderError("Failed to load elder"));
      }
    });

    on<SaveElder>((event, emit) async {
      try {
        await service.updateElder(event.elder);
        emit(ElderSaved());
      } catch (_) {
        emit(ElderError("Failed to save elder"));
      }
    });
  }
}

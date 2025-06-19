import 'package:equatable/equatable.dart';
import '../../data/models/elder_dto.dart';

abstract class ElderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ElderInitial extends ElderState {}

class ElderLoading extends ElderState {}

class ElderLoaded extends ElderState {
  final ElderDto elder;
  ElderLoaded(this.elder);

  @override
  List<Object?> get props => [elder];
}

class ElderSaved extends ElderState {}

class ElderError extends ElderState {
  final String message;
  ElderError(this.message);

  @override
  List<Object?> get props => [message];
}

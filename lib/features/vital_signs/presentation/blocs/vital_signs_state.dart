import 'package:equatable/equatable.dart';
import 'package:tukuntech/features/vital_signs/data/models/vital_sign_dto.dart';

abstract class VitalSignsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VitalSignsInitial extends VitalSignsState {}

class VitalSignsLoading extends VitalSignsState {}

class VitalSignsLoaded extends VitalSignsState {
  final VitalSignDto vitalSign;
  VitalSignsLoaded(this.vitalSign);

  @override
  List<Object?> get props => [vitalSign];
}

class VitalSignsError extends VitalSignsState {
  final String message;
  VitalSignsError(this.message);

  @override
  List<Object?> get props => [message];
}

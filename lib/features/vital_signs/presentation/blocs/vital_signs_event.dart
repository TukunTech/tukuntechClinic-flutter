import 'package:equatable/equatable.dart';

abstract class VitalSignsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadVitalSigns extends VitalSignsEvent {}

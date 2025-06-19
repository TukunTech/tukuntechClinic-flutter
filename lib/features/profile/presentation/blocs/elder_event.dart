import 'package:equatable/equatable.dart';
import '../../data/models/elder_dto.dart';

abstract class ElderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadElder extends ElderEvent {}

class SaveElder extends ElderEvent {
  final ElderDto elder;
  SaveElder(this.elder);

  @override
  List<Object> get props => [elder];
}

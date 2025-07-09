import 'package:tukuntech/features/auth/data/models/register_dto.dart';

abstract class RegisterEvent {}

class RegisterSubmitted extends RegisterEvent {
  final RegisterDTO dto;

  RegisterSubmitted(this.dto);
}
part of 'registration_bloc.dart';

@freezed
class RegistrationEvent with _$RegistrationEvent {
  const factory RegistrationEvent.started() = _Started;
  const factory RegistrationEvent.register(
      RegisterRequestModel data, XFile image) = _Register;
}

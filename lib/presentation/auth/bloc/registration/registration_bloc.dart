import 'package:bloc/bloc.dart';
import 'package:shoelaundry/data/datasources/auth_remote_datasource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/models/request/register_request_model.dart';
import '../../../../data/models/response/register_response_model.dart';

part 'registration_event.dart';
part 'registration_state.dart';
part 'registration_bloc.freezed.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthRemoteDatasource _authRemoteDatasource;

  RegistrationBloc(this._authRemoteDatasource) : super(_Initial()) {
    on<_Register>((event, emit) async {
      emit(RegistrationState.loading()); // Add this line
      final requestDataRegistrasi = RegisterRequestModel(
        name: event.data.name,
        email: event.data.email,
        password: event.data.password,
        roles: event.data.roles,
        phone: event.data.phone,
        image: event.image,
      );
      final response = await _authRemoteDatasource.register(
        requestDataRegistrasi,
      );
      response.fold(
        (l) => emit(RegistrationState.error(l)),
        (r) => emit(RegistrationState.success(r.data!)),
      );
    });
  }
}

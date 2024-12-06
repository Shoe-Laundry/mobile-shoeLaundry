import 'package:bloc/bloc.dart';
import 'package:shoelaundry/data/models/request/register_request_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/datasources/auth_remote_datasource.dart';
import '../../../../data/models/response/register_response_model.dart';

part 'update_user_event.dart';
part 'update_user_state.dart';
part 'update_user_bloc.freezed.dart';

class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  final AuthRemoteDatasource _authRemoteDatasource;

  UpdateUserBloc(this._authRemoteDatasource) : super(_Initial()) {
    on<_UpdateUser>((event, emit) async {
      emit(UpdateUserState.loading());
      final requestUpdateUser = RegisterRequestModel(
          name: event.dataUser.name,
          email: event.dataUser.email,
          roles: event.dataUser.roles,
          phone: event.dataUser.phone,
          image: event.image);
      final response =
          await _authRemoteDatasource.updateUser(requestUpdateUser);
      response.fold(((l) => emit(UpdateUserState.error(l))), (r) {
        emit(UpdateUserState.success(r.data!));
      });
    });
  }
}

part of 'update_user_bloc.dart';

@freezed
class UpdateUserState with _$UpdateUserState {
  const factory UpdateUserState.initial() = _Initial;
  const factory UpdateUserState.loading() = _Loading;
  const factory UpdateUserState.success(Data dataUpdate) = _Success;
  const factory UpdateUserState.error(String message) = _Error;
}

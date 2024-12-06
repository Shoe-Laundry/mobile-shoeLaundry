part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.success(AuthResponseModel authResponseModel) =
      _Success;
  const factory LoginState.successWithUserData(User userData) =
      _SuccessWithUserData;
  const factory LoginState.error(String message) = _Error;
}

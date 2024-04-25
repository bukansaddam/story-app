import 'package:freezed_annotation/freezed_annotation.dart';

part 'login.g.dart';
part 'login.freezed.dart';

@freezed
class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    required bool error,
    required String message,
    required LoginResult loginResult,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

@freezed
class LoginResult with _$LoginResult {
  const factory LoginResult({
    required String userId,
    required String name,
    required String token,
  }) = _LoginResult;

  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);
}

import 'dart:convert';

RegisterResponse registerFromJson(String str) =>
    RegisterResponse.fromJson(json.decode(str));

String registerToJson(RegisterResponse data) => json.encode(data.toJson());

class RegisterResponse {
  bool error;
  String message;

  RegisterResponse({
    required this.error,
    required this.message,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        error: json["error"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
      };
}

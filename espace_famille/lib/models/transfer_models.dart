import 'package:json_annotation/json_annotation.dart';
part 'transfer_models.g.dart';


@JsonSerializable()
class SignUpRequest {
  SignUpRequest(this.username, this.birthday, this.password, this.confirmPassword);

  String username;
  String birthday;
  String password;
  String confirmPassword;

  factory SignUpRequest.fromJson(Map<String, dynamic> json) => _$SignUpRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SignUpRequestToJson(this); }

@JsonSerializable()
class LogInRequest {
  LogInRequest(this.username, this.password);

  String username;
  String password;

  factory LogInRequest.fromJson(Map<String, dynamic> json) => _$LogInRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LogInRequestToJson(this); }
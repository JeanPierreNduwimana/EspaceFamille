// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpRequest _$SignUpRequestFromJson(Map<String, dynamic> json) =>
    SignUpRequest(
      json['username'] as String,
      json['birthday'] as String,
      json['password'] as String,
      json['confirmPassword'] as String,
    );

Map<String, dynamic> _$SignUpRequestToJson(SignUpRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'birthday': instance.birthday,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
    };

LogInRequest _$LogInRequestFromJson(Map<String, dynamic> json) => LogInRequest(
      json['username'] as String,
      json['password'] as String,
    );

Map<String, dynamic> _$LogInRequestToJson(LogInRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

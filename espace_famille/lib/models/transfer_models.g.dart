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

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
      DateTime.parse(json['anniversary'] as String),
      (json['avgStars'] as num).toDouble(),
      json['famId'] as String,
      json['profileDescr'] as String,
      json['profileImgUrl'] as String,
      json['username'] as String,
    );

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'anniversary': instance.anniversary.toIso8601String(),
      'avgStars': instance.avgStars,
      'famId': instance.famId,
      'profileDescr': instance.profileDescr,
      'profileImgUrl': instance.profileImgUrl,
      'username': instance.username,
    };

Food _$FoodFromJson(Map<String, dynamic> json) => Food(
      json['addedBy'] as String,
      DateTime.parse(json['dateAdded'] as String),
      json['imgUrl'] as String,
      json['name'] as String,
      (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$FoodToJson(Food instance) => <String, dynamic>{
      'addedBy': instance.addedBy,
      'dateAdded': instance.dateAdded.toIso8601String(),
      'imgUrl': instance.imgUrl,
      'name': instance.name,
      'quantity': instance.quantity,
    };

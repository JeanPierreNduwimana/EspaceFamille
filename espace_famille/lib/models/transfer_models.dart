import 'package:json_annotation/json_annotation.dart';
part 'transfer_models.g.dart';

/// dart run build_runner build --delete-conflicting-outputs
///
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

@JsonSerializable()
class Member {
  Member(this.anniversary, this.avgStars, this.famId, this.profileDescr,this.profileImgUrl, this.username);

  DateTime anniversary;
  double avgStars;
  String famId;
  String profileDescr;
  String profileImgUrl;
  String username;

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
  Map<String, dynamic> toJson() => _$MemberToJson(this); }

@JsonSerializable()
class Food {
  Food(this.addedBy, this.dateAdded, this.imgUrl, this.name,this.quantity);

  String addedBy;
  DateTime dateAdded;
  String imgUrl;
  String name;
  int quantity;

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);
  Map<String, dynamic> toJson() => _$FoodToJson(this); }
import 'package:cloud_firestore/cloud_firestore.dart';
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
  Member(this.anniversary, this.avgStars, this.famId,this.id, this.profileDescr,this.profileImgUrl, this.username);

  DateTime anniversary;
  double avgStars;
  String famId;
  String id;
  String profileDescr;
  String profileImgUrl;
  String username;

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);
  Map<String, dynamic> toJson() => _$MemberToJson(this); }

@JsonSerializable()
class Food {
  Food(this.addedBy, this.dateAdded,this.description, this.imgUrl, this.id, this.isPurchased,
      this.name, this.quantity);

  String addedBy;
  @TimestampConverter() // Use a custom converter
  DateTime dateAdded;
  String description;
  String id;
  String imgUrl;
  bool isPurchased;
  String name;
  int quantity;

  // Use JsonSerializable for automatic JSON serialization
  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);

  Map<String, dynamic> toJson() => _$FoodToJson(this);
}

// Custom converter to handle Timestamp -> DateTime conversion
class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

@JsonSerializable()
class SavedFood {
  SavedFood(this.imgUrl,this.id,this.name,this.quantity);

  String id;
  String imgUrl;
  String name;
  int quantity;

  factory SavedFood.fromJson(Map<String, dynamic> json) => _$SavedFoodFromJson(json);
  Map<String, dynamic> toJson() => _$SavedFoodToJson(this); }
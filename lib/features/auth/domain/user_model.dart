import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final int id;
  final String name;
  final String email;
  final String? phone;
  @JsonKey(name: 'member_no')
  final String? memberNo;
  final String? status;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.memberNo,
    this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
